class ComunicadosController < ApplicationController
	before_action :redirecionar_nao_logado
  before_action :set_comunicado, only: %i[ show edit update ]

  # GET /comunicados or /comunicados.json
  def index
    @usuario = get_usuario_autenticado
    @comunicado = Comunicado.new
    @comunicados = get_comunicados(@usuario)

    # Marcar visualização
    if @comunicados then
      for c in @comunicados do
        if !ReacaoComunicado.find_by(usuario_id: @usuario.id, comunicado_id: c.id) then
          reacao = ReacaoComunicado.new(
              usuario_id: @usuario.id,
              comunicado_id: c.id
          )
          reacao.save
        end
      end
      Rails.logger.info "Acessando todos os comunicados."
    else
      Rails.logger.info "Não há comunicados a serem exibidos."
    end
  end

  def reagir
    comunicado = Comunicado.find(params[:id])
    emoji = params[:emoji]
    helpers.reagir_emoji(comunicado, emoji)
    redirect_to "/comunicados"
  end

  # GET /comunicados/1 or /comunicados/1.json
  def show
    @comunicado = Comunicado.find(params[:id])
    Rails.logger.info "Acessando comunicado " + @comunicado.id.to_s + "."
  end

	def delete
		@usuario = get_usuario_autenticado
		@comunicado = Comunicado.find(params[:id])

		Rails.logger.info "Confirmando deleção do comunicado " + @comunicado.id.to_s + "."
	end

  # GET /comunicados/new
  def new
    @usuario = get_usuario_autenticado
    @comunicado = Comunicado.new
    authorize(@comunicado)

    @turmas = Array.new()
    @disciplinas = Disciplina.all
    
    if (professorTurma?) then
      disciplinas = Disciplina.where(usuario_id: @usuario.id)
      if (disciplinas) then
        for d in disciplinas do
          t = Turma.find(d.turma_id)
          if (t) then
            @turmas.push(t)
          end
        end
      end
    elsif (representanteTurma?) then
      matriculaRepresentante = Matricula.find_by(usuario_id: @usuario.id)
      turmaRepresentante = Turma.find(matriculaRepresentante.turma_id)
      @turmas.push(turmaRepresentante)
    end

    @visibilidades = get_visibilidades()
      
		Rails.logger.info "Criando novo comunicado."
  end

  # GET /comunicados/1/edit
  def edit
    @usuario = get_usuario_autenticado
    @comunicado = Comunicado.find(params[:id])
    authorize(@comunicado)

    @visibilidades = get_visibilidades()
    @turmas = Turma.all
    @disciplinas = Disciplina.all

		Rails.logger.info "Editando comunicado " + @comunicado.id.to_s + "."
  end

  # POST /comunicados or /comunicados.json
  def create
    @usuario = get_usuario_autenticado
    @comunicado = Comunicado.new(comunicado_params)
    @comunicado.usuario_id = @usuario.id
    @visibilidades = get_visibilidades()
    @turmas = Turma.all
    @disciplinas = Disciplina.all

    if @comunicado.visibilidade_comunicado == "todos_curso" then
      curso_comunicado = Curso.find_by(usuario_id: @usuario.id)
      usuarios_list = Usuario.all.select(:id, :email).take
    elsif @comunicado.visibilidade_comunicado == "todas_turmas" then
      usuarios_list = Usuario.all.select(:id, :email).take
    elsif @comunicado.visibilidade_comunicado == "todos_turma" then
      usuarios_list = Usuario.all.select(:id, :email).take
    elsif @comunicado.visibilidade_comunicado == "todos_disciplina" then
      usuarios_list = Usuario.all.select(:id, :email).take
    else
      usuarios_list = Usuario.all.select(:id, :email).take
    end

    respond_to do |format|
      if @comunicado.save
        ComunicadoMailer.with(
          usuarios_list: usuarios_list,
          comunicado: @comunicado).novo_comunicado_email.deliver_later
        
        logtxt = "Comunicado adicionado com sucesso."
        Rails.logger.info logtxt
        format.html { redirect_to comunicados_url(@comunicado), notice: logtxt }
        format.json { render :show, status: :created, location: @comunicado }
        format.turbo_stream {
          render turbo_stream: turbo_stream.prepend(
            "comunicados",
            partial: "comunicados/comunicado",
            locals: { comunicado: @comunicado }
            )
        }
      else
        Rails.logger.error "Houve um erro ao criar o comunicado."
        Rails.logger.error @comunicado.errors
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comunicado.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comunicados/1 or /comunicados/1.json
  def update
    @visibilidades = get_visibilidades()
    @turmas = Turma.all
    @disciplinas = Disciplina.all
    
    respond_to do |format|
      if @comunicado.update(comunicado_params)
        logtxt = "Comunicado atualizado com sucesso."
        Rails.logger.info logtxt
        format.html { redirect_to comunicado_url(@comunicado), notice: logtxt }
        format.json { render :show, status: :ok, location: @comunicado }
      else
        Rails.logger.error "Houve um erro ao atualizar o comunicado."
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comunicado.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comunicados/1 or /comunicados/1.json
  def destroy
    @comunicado = Comunicado.find(params[:id])
    ReacaoComunicado.where(comunicado_id: @comunicado.id).each do |reacao|
      reacao.destroy
    end
    @comunicado.destroy

    respond_to do |format|
			logtxt = "Comunicado deletado com sucesso."
			Rails.logger.info logtxt
      format.html { redirect_to comunicados_url, notice: logtxt }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comunicado
      @comunicado = Comunicado.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comunicado_params
      params.require(:comunicado).permit(:usuario_id, :turma_id, :visibilidade_comunicado, :corpo, imagens: [])
    end

    def get_comunicados(usuario_autenticado)
      usuarios = Array.new()
      comunicados = Array.new()

      # Obtendo todos os comunicados da coordenação do curso
      curso_atual = helpers.current_curso(usuario_autenticado)

      if curso_atual then
        comunicados += Comunicado.where(usuario_id: curso_atual.usuario_id, visibilidade_comunicado: :todos_curso)
      end

      # Obtendo todos os comunicados de turmas
      comunicados_de_professores = Array.new()

      if curso_atual then
        disciplinas_do_curso = Disciplina.where(curso_id: curso_atual.id)
        disciplinas_do_curso.each do |d|
          comunicados_de_professores += Comunicado.where(usuario_id: d.usuario_id)
        end
      end
      
      comunicados += comunicados_de_professores

      return comunicados
    end

    def get_visibilidades
      visibilidades = {}

      if (visivelTodosCurso?)
        visibilidades['todos_curso'] =  Comunicado.visibilidade_comunicados[:todos_curso]
      end
      if (visivelTodasTurmas?)
        visibilidades['todas_turmas'] =  Comunicado.visibilidade_comunicados[:todas_turmas]
      end
      if (visivelTodosTurma?)
        visibilidades['todos_turma'] =  Comunicado.visibilidade_comunicados[:todos_turma]
      end
      if (visivelTodosDisciplinas?)
        visibilidades['todos_disciplina'] =  Comunicado.visibilidade_comunicados[:todos_disciplina]
      end

      return visibilidades
    end

    def visivelTodosCurso?
      coordenadorCurso?
    end

    def visivelTodasTurmas?
      !coordenadorCurso? && professorTurma?
    end

    def visivelTodosTurma?
      !coordenadorCurso? && (professorTurma? || representanteTurma?)
    end

    def visivelTodosDisciplinas?
      !coordenadorCurso? && (professorTurma?)
    end
  
    def coordenadorCurso?
      Usuario.cargo_usuarios[@usuario.cargo_usuario] == 1
    end
  
    def professorTurma?
      Usuario.cargo_usuarios[@usuario.cargo_usuario] == 2
    end
  
    def representanteTurma?
      Usuario.cargo_usuarios[@usuario.cargo_usuario] == 3
    end
end
