class MensagensController < ApplicationController
  before_action :set_mensagem, only: %i[ show edit update destroy ]

  # GET /mensagens or /mensagens.json
  def index
    @usuario_autenticado = get_usuario_autenticado
    @usuario_destinatario = nil
    @mensagens = nil

    @mensagens_usuarios = Usuario.where.not(id: @usuario_autenticado.id)
    @mensagens_turmas = Turma.all

    if (params) then
      @usuario_destinatario = params[:id]
      @mensagens = Mensagem.where(
          remetente_id: @usuario_autenticado.id,
          destinatario_id: @usuario_destinatario
          ) + 
        Mensagem.where(
          remetente_id: @usuario_destinatario,
          destinatario_id: @usuario_autenticado.id
          )
      @mensagens = @mensagens.uniq
      @mensagens = @mensagens.sort_by{|m| m[:created_at]}
    
      # Marcar visualização
      marcar_visualizacao_mensagens(@usuario_autenticado, @mensagens)
    else
      Rails.logger.info "Não há mensagens a serem exibidas."
    end
  end

  def turma
    @usuario_autenticado = get_usuario_autenticado
    @usuario_destinatario = nil
    @mensagens = nil

    @mensagens_usuarios = Usuario.where.not(id: @usuario_autenticado.id)
    @mensagens_turmas = Turma.all

    if (params) then
      @usuario_destinatario = @usuario_autenticado.id
      @usuarios_turma = Usuario.joins(:matricula).where(
        matricula: {
          turma_id: params[:id]
        }
      )
      @mensagens = Array.new()
      @usuarios_turma.each do |u|
        @mensagens += Mensagem.where(
            remetente_id: @usuario_autenticado.id,
            destinatario_id: u.id
            ) + 
          Mensagem.where(
            remetente_id: u.id,
            destinatario_id: @usuario_autenticado.id
            )
      end
      @mensagens = @mensagens.uniq
      @mensagens = @mensagens.sort_by{|m| m[:created_at]}
    
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

    @mensagem = Mensagem.new(mensagem_params)
    @mensagens_usuarios = Usuario.where.not(id: @usuario_autenticado.id)
    @mensagens = Mensagem.all

    respond_to do |format|
      if @mensagem.save
        format.html { redirect_to '/mensagens/' + params[:id].to_s }
        format.json { render :index, status: :created, location: @mensagem }
      else
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

      params[:mensagem][:remetente_id] = @usuario_autenticado.id
      params[:mensagem][:destinatario_id] = m.usuario_id
      mensagem = Mensagem.new(mensagem_params)
  
      respond_to do |format|
        if mensagem.save
          format.json { render :index, status: :created, location: mensagem }
        else
          format.html { render :index, status: :unprocessable_entity }
          format.json { render json: mensagem.errors, status: :unprocessable_entity }
        end
      end
    end
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
      params.require(:mensagem).permit(:remetente_id, :destinatario_id, :corpo)
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
