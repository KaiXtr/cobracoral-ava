class ComunicadosController < ApplicationController
	before_action :redirecionar_nao_logado
  before_action :set_comunicado, only: %i[ show edit update destroy ]

  # GET /comunicados or /comunicados.json
  def index
    @usuario = usuario_autenticado
    @comunicado = Comunicado.new
    @comunicados = get_comunicados(@usuario)

    # Marcar visualização
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

  # GET /comunicados/new
  def new
    @usuario = usuario_autenticado
    @comunicado = Comunicado.new
    authorize(@comunicado)

    @turmas = Turma.all
    @visibilidades = get_visibilidades()
    
    VisibilidadeComunicado.all
		Rails.logger.info "Criando novo comunicado."
  end

  # GET /comunicados/1/edit
  def edit
    @usuario = usuario_autenticado
    @comunicado = Comunicado.find(params[:id])
    authorize(@comunicado)

    @turmas = Turma.all
    @visibilidades = get_visibilidades()
		Rails.logger.info "Editando comunicado " + @comunicado.id + "."
  end

  # POST /comunicados or /comunicados.json
  def create
    @usuario = usuario_autenticado
    @comunicado = Comunicado.new(comunicado_params)
    @comunicado.usuario_id = @usuario.id

    respond_to do |format|
      if @comunicado.save
        logtxt = "Comunicado adicionado com sucesso."
        Rails.logger.info logtxt
        format.html { redirect_to comunicados_url(@comunicado), notice: logtxt }
        format.json { render :show, status: :created, location: @comunicado }
      else
        Rails.logger.error "Houve um erro ao criar o comunicado."
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comunicado.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comunicados/1 or /comunicados/1.json
  def update
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
      params.require(:comunicado).permit(:usuario_id, :turma_id, :visibilidade_comunicado_id, :corpo, imagens: [])
    end

    def get_comunicados(usuario_autenticado)
      # TODO possivelmente uma boa implementação de cache Redis

      usuarios = Array.new()
      comunicados = Array.new()
      curso_atual = helpers.current_curso(usuario_autenticado)

      # Obtendo todos os comunicados da coordenação
      comunicados_da_coordenacao = Comunicado.where(
        usuario_id: curso_atual.usuario_id
      )

      '''estudantes_do_curso = Matricula.joins(:turma).where(
        turma: { curso_id: curso_atual.id }
      )

      comunicados_do_curso = Comunicado.joins(:usuario).where(
        usuario: { id: id }
      )'''

      # comunicados.join(comunicados_da_coordenacao)

      return comunicados_da_coordenacao
    end

    def get_visibilidades
      visibilidades = Array.new()

      if (visivelTodosCurso?)
        visibilidades.push(VisibilidadeComunicado.find(1))
      end
      if (visivelTodasTurmas?)
        visibilidades.push(VisibilidadeComunicado.find(2))
      end
      if (visivelTodosTurma?)
        visibilidades.push(VisibilidadeComunicado.find(3))
      end
      if (visivelTodosDisciplinas?)
        visibilidades.push(VisibilidadeComunicado.find(4))
      end

      return visibilidades
    end

    def visivelTodosCurso?
      coordenadorCurso?
    end

    def visivelTodasTurmas?
      coordenadorCurso? || professorTurma?
    end

    def visivelTodosTurma?
      coordenadorCurso? || professorTurma? || representanteTurma?
    end

    def visivelTodosDisciplinas?
      coordenadorCurso? || professorTurma?
    end
  
    def coordenadorCurso?
      curso = Curso.find_by(usuario_id: @usuario.id)
      if curso
        true
      else
        false
      end
    end
  
    def professorTurma?
      disciplina = Disciplina.find_by(usuario_id: @usuario.id)
      if (disciplina)
        true
      else
        false
      end
    end
  
    def representanteTurma?
      matricula = Matricula.find_by(usuario_id: @usuario.id)
      if matricula then
          cargo = MatriculaCargo.find(matricula.matricula_cargo_id)
          cargo.id == 3
      else
          false
      end
    end
end
