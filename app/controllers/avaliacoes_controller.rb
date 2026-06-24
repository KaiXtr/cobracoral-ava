class AvaliacoesController < ApplicationController
  before_action :set_avaliacao, only: %i[ show edit update destroy ]
	layout 'avaliacao'

  # GET /avaliacaos or /avaliacaos.json
  def index
    @avaliacaos = Avaliacao.all
  end

  # GET /avaliacaos/1 or /avaliacaos/1.json
  def show
    authorize @avaliacao
    usuario = get_usuario_autenticado
    avaliacao = Avaliacao.find(params[:id])
    unidade_da_avaliacao = UnidadeDisciplina.find_by(id: avaliacao.unidade_disciplina_id)
    @disciplina_avaliacao = Disciplina.find_by(id: unidade_da_avaliacao.disciplina_id)

    @questao_index = 1

    @tentativas_avaliacao = TentativaAvaliacao.where(usuario_id: usuario.id, avaliacao_id: avaliacao.id)
    @tentativa_index = 1

    @avaliacao_pagina = 0
    @max_questoes = avaliacao.quant_questoes

    @respostas_tentativa = nil
    if (session[:tentativa_index] != nil) then
      @respostas_tentativa = RespostaTentativa.where(
        tentativa_avaliacao_id: session[:tentativa_index]
      )
    end
  end

  # Iniciar tentativa com base na sessão do usuário
  def iniciar
    usuario = get_usuario_autenticado
    avaliacao = Avaliacao.find(params[:id])

    tentativa_avaliacao = TentativaAvaliacao.new(
      avaliacao_id: avaliacao.id,
      usuario_id: usuario.id
    )

    if tentativa_avaliacao.save then
      session[:tentativa_index] = tentativa_avaliacao.id
      session[:tentativa_inicio] = Time.now

      Rails.logger.info "Iniciando tentativa para avaliação."
      redirect_to "/avaliacoes/" + params[:id].to_s + "/1"
    else
      logtxt = "Não foi possível iniciar tentativa de avaliação. Tente novamente mais tarde."
      Rails.logger.info logtxt
      notice = logtxt
      redirect_to "/avaliacoes/" + avaliacao.id.to_s
    end
  end

  def questao
    usuario = get_usuario_autenticado
    @avaliacao = Avaliacao.find(params[:id])
    authorize(@avaliacao)

    unidade_da_avaliacao = UnidadeDisciplina.find_by(id: @avaliacao.unidade_disciplina_id)
    @disciplina_avaliacao = Disciplina.find_by(id: unidade_da_avaliacao.disciplina_id)

    @tentativas_avaliacao = TentativaAvaliacao.where(usuario_id: usuario.id, avaliacao_id: @avaliacao.id)
    @tentativa_index = 1

    @avaliacao_pagina = 0
    @max_questoes = @avaliacao.quant_questoes

    if (params[:pagina]) then
      @avaliacao_pagina = params[:pagina].to_i
      questoes_avaliacao = QuestaoAvaliacao.where(avaliacao_id: @avaliacao.id).order(:id)
      @questao_avaliacao = questoes_avaliacao[@avaliacao_pagina - 1]
      @alternativas_questao = AlternativaQuestao.where(questao_avaliacao: @questao_avaliacao.id)
      @alternativa_selecionada = 0

      tentativa_avaliacao = TentativaAvaliacao.find_by(id: session[:tentativa_index])
      if tentativa_avaliacao then
        resposta_alternativa = RespostaTentativa.find_by(
          tentativa_avaliacao_id: tentativa_avaliacao.id,
          questao_avaliacao_id: @questao_avaliacao.id
        )
        if resposta_alternativa != nil then
          @alternativa_selecionada = resposta_alternativa.alternativa_questao_id
        end
      end
    end
  end

  # Atualizar tentativa da avaliação
  def salvar
    usuario = get_usuario_autenticado
    avaliacao = Avaliacao.find(params[:id])
    questao_id = params[:questao]
    alternativa_id = params[:alternativa]
    unidade_da_avaliacao = UnidadeDisciplina.find_by(id: avaliacao.unidade_disciplina_id)

    if isUsuarioEstudante(usuario) then
      tentativa_avaliacao = TentativaAvaliacao.find(session[:tentativa_index])
      if tentativa_avaliacao == nil then
        Rails.logger.error "Não foi localizada tentativa de avaliação ao salvar."
      else
        resposta_tentativa = RespostaTentativa.find_by(
          tentativa_avaliacao_id: tentativa_avaliacao.id,
          questao_avaliacao_id: questao_id,
        )
        if resposta_tentativa == nil then
          resposta_tentativa = RespostaTentativa.new(
            tentativa_avaliacao_id: tentativa_avaliacao.id,
            questao_avaliacao_id: questao_id,
            alternativa_questao_id: alternativa_id
          )
        end

        # Atualizando resposta da tentativa
        resposta_tentativa.alternativa_questao_id = alternativa_id
        
        if resposta_tentativa.save then
          Rails.logger.info "Salvando tentativa da avaliação " + avaliacao.nome_avaliacao + " da unidade " + unidade_da_avaliacao.nome_unidade + "."
        else
          logtxt = "Houve uma falha ao salvar tentativa da avaliação " + avaliacao.nome_avaliacao + " da unidade " + unidade_da_avaliacao.nome_unidade + "."
          Rails.logger.info logtxt
        end
      end
    else
      Rails.logger.info "Coordenador(a)/Professor(a) não salva tentativas de avaliação."
    end
    
    redirect_to "/avaliacoes/" + avaliacao.id.to_s + "/" + (questao_id.to_i - 1).to_s
  end

  # Encerrar tentativa de avaliação
  def finalizar
    usuario = get_usuario_autenticado
    avaliacao = Avaliacao.find(params[:id])
    tentativa_avaliacao = TentativaAvaliacao.find(session[:tentativa_index])

    if tentativa_avaliacao then
      nota = 0
      respostas_tentativa = RespostaTentativa.where(tentativa_avaliacao_id: tentativa_avaliacao.id)
      
      for r in respostas_tentativa
        alternativa_questao = AlternativaQuestao.find(r.alternativa_questao_id)
        if alternativa_questao.is_correta == true then
          questao_avaliacao = QuestaoAvaliacao.find(r.questao_avaliacao_id)
          nota += avaliacao.nota_total / avaliacao.quant_questoes
        end
      end

      tentativa_avaliacao.nota = nota
      if tentativa_avaliacao.save then
        session[:tentativa_index] = nil
        Rails.logger.info "Encerrando tentativa de avaliação."
      else
        Rails.logger.info "Houve um problema ao salvar a nota da tentativa de avaliação."
      end
    else
      Rails.logger.info "Houve um problema ao encerrar a tentativa de avaliação."
    end

    redirect_to "/avaliacoes/" + avaliacao.id.to_s
  end

  # GET /avaliacaos/new
  def new
    @avaliacao = Avaliacao.new
  end

  # GET /avaliacaos/1/edit
  def edit
  end

  # POST /avaliacaos or /avaliacaos.json
  def create
    @avaliacao = Avaliacao.new(avaliacao_params)

    respond_to do |format|
      if @avaliacao.save
        format.html { redirect_to @avaliacao, notice: "Avaliacao was successfully created." }
        format.json { render :show, status: :created, location: @avaliacao }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @avaliacao.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /avaliacaos/1 or /avaliacaos/1.json
  def update
    respond_to do |format|
      if @avaliacao.update(avaliacao_params)
        format.html { redirect_to @avaliacao, notice: "Avaliacao was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @avaliacao }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @avaliacao.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /avaliacaos/1 or /avaliacaos/1.json
  def destroy
    @avaliacao.destroy!

    respond_to do |format|
      format.html { redirect_to avaliacaos_path, notice: "Avaliacao was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_avaliacao
      @avaliacao = Avaliacao.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def avaliacao_params
      params.fetch(:avaliacao, {})
    end

    def isUsuarioEstudante(usuario)
      Usuario.cargo_usuarios[usuario.cargo_usuario] > 2
    end
end
