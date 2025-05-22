class MensagensController < ApplicationController
  before_action :set_mensagem, only: %i[ show edit update destroy ]

  # GET /mensagens or /mensagens.json
  def index
    @usuario_autenticado = get_usuario_autenticado
    @mensagens_usuarios = set_mensagens_usuarios(@usuario_autenticado)
    @form_submit_link = '/mensagens/'
    @id_param = nil
    @mensagens = nil

    if (params) then
      @id_param = params[:id]
      @form_submit_link = '/mensagens/' + @id_param.to_s

      @mensagens = Mensagem.where(
          remetente_id: @usuario_autenticado.id,
          destinatario_id: @id_param,
          is_privada: true
          ) + 
        Mensagem.where(
          remetente_id: @id_param,
          destinatario_id: @usuario_autenticado.id,
          is_privada: true
          )
      @mensagens = @mensagens.uniq
      @mensagens = @mensagens.sort_by{|m| m[:created_at]}.reverse
    
      # Marcar visualização
      marcar_visualizacao_mensagens(@usuario_autenticado, @mensagens)
    else
      Rails.logger.info "Não há mensagens a serem exibidas."
    end
  end

  def turma
    @usuario_autenticado = get_usuario_autenticado
    @mensagens_usuarios = set_mensagens_usuarios(@usuario_autenticado)
    @form_submit_link = '/mensagens/turma/'
    @mensagens = nil
    @id_param = nil

    if (params) then
      @id_param = params[:id]
      @form_submit_link = '/mensagens/turma/' + @id_param.to_s

      @usuarios_turma = Usuario.joins(:matricula).where(
        matricula: {
          turma_id: @id_param
        }
      )
      @mensagens = Array.new()
      @usuarios_turma.each do |u|
        @mensagens += Mensagem.where(
            remetente_id: @usuario_autenticado.id,
            destinatario_id: u.id,
            is_privada: false
            ) + 
          Mensagem.where(
            remetente_id: u.id,
            destinatario_id: @usuario_autenticado.id,
            is_privada: false
            )
      end
      @mensagens = @mensagens.uniq
      @mensagens = @mensagens.sort_by{|m| m[:created_at]}.reverse
    
      # Marcar visualização
      marcar_visualizacao_mensagens(@usuario_autenticado, @mensagens)
    else
      Rails.logger.info "Não há mensagens a serem exibidas."
    end

    render 'index'
  end

  def reagir
    @usuario_autenticado = get_usuario_autenticado
    mensagem = Mensagem.find(params[:id])
    emoji = params[:emoji]
    helpers.reagir_emoji_mensagem(mensagem, emoji)

    if mensagem.destinatario_id == @usuario_autenticado.id then
      redirect_to "/mensagens/" + mensagem.remetente_id.to_s
    else
      redirect_to "/mensagens/" + mensagem.destinatario_id.to_s
    end
  end

  # POST /mensagens or /mensagens.json
  def create
    @usuario_autenticado = get_usuario_autenticado
    params[:mensagem][:remetente_id] = @usuario_autenticado.id
    params[:mensagem][:destinatario_id] = params[:id]
    params[:mensagem][:is_privada] = true

    @mensagem = Mensagem.new(mensagem_params)
    @mensagens_usuarios = Usuario.where.not(id: @usuario_autenticado.id)
    @mensagens = Mensagem.all

    respond_to do |format|
      if @mensagem.save
        dest = Usuario.find(@mensagem.destinatario_id)
        dest.updated_at = Time.now
        dest.save
        
        @preferencias_usuario = PreferenciasUsuario.find_by(usuario_id: dest.id)
        if @preferencias_usuario.notificacao_nova_mensagem then
          MensagemMailer.with(mensagem: @mensagem).nova_mensagem_email.deliver_later
        end
        
        Rails.logger.info "Mensagem para " + dest.id.to_s + ': "' + @mensagem.corpo.body.to_s + '"'
        format.html { redirect_to '/mensagens/' + params[:id].to_s }
        format.json { render :index, status: :created, location: @mensagem }
      else
        Rails.logger.error "Houve um erro ao enviar a mensagem."
        Rails.logger.error @mensagem.errors
        format.html { render :index, status: :unprocessable_entity }
        format.json { render json: @mensagem.errors, status: :unprocessable_entity }
      end
    end
  end

  def turmaCreate
    @usuario_autenticado = get_usuario_autenticado
    @mensagens_usuarios = Usuario.all
    @mensagens = Mensagem.all

    @matriculas_turma = Matricula.where(turma_id: params[:id])
    @matriculas_turma.each do |m|
      if m.usuario_id != @usuario_autenticado.id then
        params[:mensagem][:remetente_id] = @usuario_autenticado.id
        params[:mensagem][:destinatario_id] = m.usuario_id
        params[:mensagem][:is_privada] = false
        mensagem = Mensagem.new(mensagem_params)
      
        respond_to do |format|
          if mensagem.save
            dest = Turma.find(m.turma_id)
            dest.updated_at = Time.now
            dest.save

            @preferencias_usuario = PreferenciasUsuario.find_by(usuario_id: m.usuario_id)
            if @preferencias_usuario.notificacao_nova_mensagem then
              MensagemMailer.with(mensagem: @mensagem).nova_mensagem_email.deliver_later
            end

            Rails.logger.info "Mensagem para a turma " + params[:id].to_s + ': "' + mensagem.corpo.body.to_s + '"'
            format.json { render :index, status: :created, location: mensagem }
          else
            Rails.logger.error "Houve um erro ao enviar a mensagem da turma."
            Rails.logger.error mensagem.errors
            format.json { render json: mensagem.errors, status: :unprocessable_entity }
          end
        end
      end
    end

    render 'index'
  end

  # PATCH/PUT /mensagens/1 or /mensagens/1.json
  def update
    respond_to do |format|
      if @mensagem.update(mensagem_params)
        format.html { redirect_to mensagen_url(@mensagem), notice: "Mensagem was successfully updated." }
        format.json { render :show, status: :ok, location: @mensagem }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @mensagem.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mensagens/1 or /mensagens/1.json
  def destroy
    @mensagem.destroy!

    respond_to do |format|
      format.html { redirect_to mensagens_url, notice: "Mensagem was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mensagem
      @mensagem = Mensagem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def mensagem_params
      params.require(:mensagem).permit(:remetente_id, :destinatario_id, :corpo, :is_privada)
    end

    def set_mensagens_usuarios(usuario_autenticado)
      mensagens_usuarios = Usuario.where.not(id: usuario_autenticado.id)
      if usuario_autenticado.cargo_usuario == :coordenador then
        curso_coordenador = Curso.find_by(usuario_id: usuario_autenticado.id)
        mensagens_usuarios += Turma.where(curso_id: curso_coordenador.id)
      elsif usuario_autenticado.cargo_usuario == :professor then
        mensagens_usuarios += Turma.all
      else
        matricula_estudante = Matricula.find_by(usuario_id: usuario_autenticado.id)
        mensagens_usuarios += [Turma.find(matricula_estudante.turma_id)]
      end
      mensagens_usuarios = mensagens_usuarios.sort_by{|m| m[:updated_at]}.reverse
      mensagens_usuarios = [usuario_autenticado] + mensagens_usuarios

      return mensagens_usuarios
    end

    def marcar_visualizacao_mensagens(usuario_autenticado, mensagens)
      if mensagens then
        for m in mensagens do
          if !ReacaoMensagem.find_by(
            usuario_id: usuario_autenticado.id,
            mensagem_id: m.id,
            emoji: 'x') then

            if !ReacaoMensagem.find_by(
            usuario_id: usuario_autenticado.id,
            mensagem_id: m.id,
            emoji: nil) then
              reacao = ReacaoMensagem.new(
                  usuario_id: usuario_autenticado.id,
                  mensagem_id: m.id,
                  emoji: nil
              )
              reacao.save
            else
              reacao = ReacaoMensagem.find_by(
                usuario_id: usuario_autenticado.id,
                mensagem_id: m.id,
                emoji: nil
              )
              reacao.emoji = 'x'
              reacao.save
            end
          end
        end
        Rails.logger.info "Acessando todas as mensagens."
      else
        Rails.logger.info "Não há mensagens a serem exibidas."
      end
    end
end
