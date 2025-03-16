class ConteudosController < ApplicationController
	before_action :redirecionar_nao_logado
  before_action :set_conteudo, only: %i[ show edit update destroy ]

  # GET /conteudos or /conteudos.json
  def index
    usuario = usuario_autenticado
    @conteudos = Conteudo.all
    Rails.logger.info "Acessando todos os conteúdos."
  end

  # GET /conteudos/1 or /conteudos/1.json
  def show
    authorize @conteudo
    usuario = usuario_autenticado
    conteudo = Conteudo.find(params[:id])
    unidade_do_conteudo = UnidadeDisciplina.find_by(id: conteudo.unidade_disciplina_id)
    @disciplina_conteudo = Disciplina.find_by(id: unidade_do_conteudo.disciplina_id)

    if helpers.is_conteudo_indisponivel(@conteudo) then
      redirect_to '/disciplinas/' + @disciplina_conteudo.id.to_s
    end

    @proximoConteudo = Conteudo.joins(:unidade_disciplina).find_by(
      id: conteudo.id + 1,
      unidade_disciplina: { disciplina_id: @disciplina_conteudo.id }
    )
    
    # Iniciar leitura do conteúdo e contabilizar conclusão
    @conclusao_conteudo = 0

    if isUsuarioEstudante(usuario) then
      @leitura_conteudo = LeituraConteudo.find_by(
        conteudo_id: conteudo.id,
        usuario_id: usuario.id
      )
      if @leitura_conteudo then
        @conclusao_conteudo = @leitura_conteudo.conclusao
      else
        @leitura_conteudo = LeituraConteudo.new(
          conteudo_id: conteudo.id,
          usuario_id: usuario.id
        )
        @leitura_conteudo.save
        Rails.logger.info "Criando progresso de leitura do conteúdo " + conteudo.nome_conteudo + "."
      end
    end
    Rails.logger.info "Acessando conteúdo " + conteudo.nome_conteudo + " da unidade " + unidade_do_conteudo.nome_unidade + "."
  end

  # Atualizar leitura do conteúdo
  def salvar
    usuario = usuario_autenticado
    conteudo = Conteudo.find(params[:id])
    unidade_do_conteudo = UnidadeDisciplina.find_by(id: conteudo.unidade_disciplina_id)

    if isUsuarioEstudante(usuario) then
      @leitura_conteudo = LeituraConteudo.find_by(
        conteudo_id: conteudo.id,
        usuario_id: usuario.id
      )
      if @leitura_conteudo == nil then
        @leitura_conteudo = LeituraConteudo.new(
          conteudo_id: conteudo.id,
          usuario_id: usuario.id
        )
      end

      # Salvando conclusão da leitura do conteúdo
      @leitura_conteudo.conclusao = 1
      if @leitura_conteudo.save then
        Rails.logger.info "Salvando progresso de leitura do conteúdo " + conteudo.nome_conteudo + " da unidade " + unidade_do_conteudo.nome_unidade + "."
      else
        Rails.logger.error "Houve uma falha ao salvar progresso de leitura do conteúdo " + conteudo.nome_conteudo + " da unidade " + unidade_do_conteudo.nome_unidade + "."
      end
    else
      Rails.logger.info "Coordenador(a)/Professor(a) não salva progresso de leitura."
    end

    # Redirecionando para próximo conteúdo ou de volta à disciplina
    @disciplina_conteudo = Disciplina.find_by(id: unidade_do_conteudo.disciplina_id)
    @proximoConteudo = Conteudo.joins(:unidade_disciplina).find_by(
      id: conteudo.id + 1,
      unidade_disciplina: { disciplina_id: @disciplina_conteudo.id }
    )
    if @proximoConteudo then
      Rails.logger.info "Redirecionando para o próximo conteúdo da unidade " + unidade_do_conteudo.nome_unidade + "."
      redirect_to conteudo_path(id: @proximoConteudo.id)
    else
      @disciplina_conteudo = Disciplina.find_by(id: unidade_do_conteudo.disciplina_id)
      Rails.logger.info "Voltando para todos os conteúdos da disciplina " + @disciplina_conteudo.nome_disciplina + "."
      redirect_to disciplina_path(@disciplina_conteudo)
    end
  end

  # GET /conteudos/new
  def new
    @conteudo = Conteudo.new
    @conteudo.nome_conteudo = "Nome do conteúdo "
    professor = usuario_autenticado
    
    @disciplina_conteudo = Disciplina.find_by(usuario_id: professor.id)
    Rails.logger.info "Criando novo conteúdo."
  end

  # GET /conteudos/1/edit
  def edit
    authorize @conteudo
    Rails.logger.info "Editando conteúdo " + @conteudo.nome_conteudo + "."
  end

  # POST /conteudos or /conteudos.json
  def create
    @conteudo = Conteudo.new(conteudo_params)

    respond_to do |format|
      if @conteudo.save
        logtxt = "Conteúdo " + @conteudo.nome_conteudo + " atualizado com sucesso."
        Rails.logger.info logtxt
        format.html { redirect_to conteudo_url(@conteudo), notice: logtxt }
        format.json { render :show, status: :created, location: @conteudo }
      else
			  Rails.logger.error "Houve um erro ao criar o conteúdo " + @conteudo.nome_conteudo + "."
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @conteudo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /conteudos/1 or /conteudos/1.json
  def update
    respond_to do |format|
      if @conteudo.update(conteudo_params)
        logtxt = "Conteúdo " + @conteudo.nome_conteudo + " atualizado com sucesso."
        Rails.logger.info logtxt
        format.html { redirect_to conteudo_url(@conteudo), notice: logtxt }
        format.json { render :show, status: :ok, location: @conteudo }
      else
			  Rails.logger.error "Houve um erro ao atualizar o conteúdo " + @conteudo.nome_conteudo + "."
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @conteudo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /conteudos/1 or /conteudos/1.json
  def destroy
    @conteudo.destroy

    respond_to do |format|
			logtxt = "Conteúdo " + @conteudo.nome_conteudo + " deletado com sucesso."
			Rails.logger.info logtxt
      format.html { redirect_to conteudos_url, notice: logtxt }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_conteudo
      @conteudo = Conteudo.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def conteudo_params
      params.require(:conteudo).permit(:unidade_disciplina_id, :nome_conteudo, :corpo)
    end

    def isUsuarioEstudante(usuario)
        matricula = Matricula.find_by(usuario_id: usuario.id)
        if matricula then
          cargo = MatriculaCargo.find(matricula.matricula_cargo_id)
          cargo.id > 2
        else
          false
        end
    end
end
