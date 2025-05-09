class ComunicadosController < ApplicationController
	before_action :redirecionar_nao_logado
  before_action :set_comunicado, only: %i[ show edit update destroy ]

  # GET /comunicados or /comunicados.json
  def index
    @usuario = usuario_autenticado
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
		@usuario = usuario_autenticado
		@comunicado = Comunicado.find(params[:id])

		Rails.logger.info "Confirmando deleção do comunicado " + @comunicado.id.to_s + "."
	end

  # GET /comunicados/new
  def new
    @usuario = usuario_autenticado
    @comunicado = Comunicado.new
    authorize(@comunicado)

    @turmas = Turma.all
    @visibilidades = get_visibilidades()
      
		Rails.logger.info "Criando novo comunicado."
  end

  # GET /comunicados/1/edit
  def edit
    @usuario = usuario_autenticado
    @comunicado = Comunicado.find(params[:id])
    authorize(@comunicado)

    @turmas = Turma.all
    @visibilidades = get_visibilidades()
		Rails.logger.info "Editando comunicado " + @comunicado.id.to_s + "."
  end

  # POST /comunicados or /comunicados.json
  def create
    @usuario = usuario_autenticado
    @comunicado = Comunicado.new(comunicado_params)
    @comunicado.usuario_id = @usuario.id

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
      # TODO possivelmente uma boa implementação de cache Redis

      usuarios = Array.new()
      comunicados = Array.new()

      # Obtendo todos os comunicados da coordenação do curso
      curso_atual = helpers.current_curso(usuario_autenticado)

      comunicados_da_coordenacao = nil

      if curso_atual then
        comunicados_da_coordenacao = Comunicado.where(
          usuario_id: curso_atual.usuario_id,
          visibilidade_comunicado: 1
        )
      end

      # Obtendo todos os comunicados de professores (deve haver uma forma mais eficiente)
      comunicados_de_professores = Array.new()

      if curso_atual then
        disciplinas_do_curso = Disciplina.where(curso_id: curso_atual.id)
        disciplinas_do_curso.each do |d|
          comunicados_de_professores += Comunicado.where(usuario_id: d.usuario_id)
        end
      end

      comunicados = comunicados_da_coordenacao
      
      if comunicados_da_coordenacao then
        comunicados += comunicados_de_professores
      end

      return comunicados
    end

    def get_visibilidades
      visibilidades = Array.new()

      if (visivelTodosCurso?)
        visibilidades.push(Comunicado.visibilidade_comunicados[:todos_curso])
      end
      if (visivelTodasTurmas?)
        visibilidades.push(Comunicado.visibilidade_comunicados[:todas_turmas])
      end
      if (visivelTodosTurma?)
        visibilidades.push(Comunicado.visibilidade_comunicados[:todos_turma])
      end
      if (visivelTodosDisciplinas?)
        visibilidades.push(Comunicado.visibilidade_comunicados[:todos_disciplina])
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
      Usuario.cargo_usuarios[usuario.cargo_usuario] == 3
    end
end
