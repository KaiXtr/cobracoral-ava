class DisciplinasController < ApplicationController
	before_action :redirecionar_nao_logado
  before_action :set_disciplina, only: %i[ show edit update destroy ]

  # GET /disciplinas or /disciplinas.json
  def index
		@usuario = usuario_autenticado
    @disciplina = Disciplina.new
		matricula = Matricula.find_by(usuario_id: usuario_autenticado.id)
    if matricula then
      @disciplinas = Disciplina.where(
        turma_id: matricula.turma_id,
        semestre: matricula.semestre
      )
    else
      @disciplinas = Disciplina.all
    end
    @unidades_disciplina = UnidadeDisciplina.new
    @conteudos = Conteudo.new
    @curso = Curso.new

    Rails.logger.info "Acessando todas as disciplinas."
  end

  # GET /disciplinas/1 or /disciplinas/1.json
  def show
    @estaEditando = false
    @usuario = usuario_autenticado
    @disciplina = Disciplina.find(params[:id])
    authorize @disciplina

    @turma = Turma.find(@disciplina.turma_id)
    @curso = Curso.find_by(id: @disciplina.curso_id)
    @unidades_disciplina = UnidadeDisciplina.where(disciplina_id: @disciplina.id)
    @conteudos = Conteudo.joins(:unidade_disciplina)
      .where(
        unidade_disciplina: { 
          disciplina_id: @disciplina.id
        }
      )

    Rails.logger.info "Acessando disciplina " + @disciplina.nome_disciplina + "."
  end

  # GET /disciplinas/new
  def new
    @disciplina = Disciplina.new
    authorize(@disciplina)

		# Verificando nível de acesso do usuário
		usuario = usuario_autenticado
    
		# Se professor, apenas cursos onde leciona
		if Usuario.cargo_usuarios[usuario.cargo_usuario] > 1 then
			if usuario.cargo_usuario == 2 then
				turmas_matriculadas = Turma.joins(:disciplina).where(
					disciplina: { usuario_id: usuario.id }
				)
				@cursos = Array.new

				# Adicionar cursos das turmas matriculadas do usuário
				for turma_matriculada in turmas_matriculadas do
					curso_da_turma = Curso.find(turma_matriculada.curso_id)
					@cursos.push(curso_da_turma)
				end

        Rails.logger.info "Criando nova disciplina com nível de acesso Professor(a)."
			# Se não tiver acesso, não listar cursos
			else
				@cursos = nil
        Rails.logger.info "Usuário(a) não possui permissão para criar novas disciplinas."
			end
		# Se coordenador, apenas cursos onde coordena
		else
			@cursos = Curso.where(usuario_id: usuario.id)
      Rails.logger.info "Criando nova disciplina com nível de acesso Coordenador(a)."
		end
  end

  # GET /disciplinas/1/edit
  def edit
    @estaEditando = true
    @usuario = usuario_autenticado
    @disciplina = Disciplina.find(params[:id])

    authorize(@disciplina)

    @unidades_disciplina = UnidadeDisciplina.where(disciplina_id: @disciplina.id)
    @conteudos = Conteudo.joins(:unidade_disciplina)
      .where(
        unidade_disciplina: { 
          disciplina_id: @disciplina.id
        }
      )
      
    Rails.logger.info "Editando disciplina " + @disciplina.nome_disciplina + "."
  end

	def delete
		@usuario = usuario_autenticado
		@disciplina = Disciplina.find(params[:id])

		Rails.logger.info "Deletando disciplina " + @disciplina.nome_disciplina + "."
	end

  # POST /disciplinas or /disciplinas.json
  def create
    @disciplina = Disciplina.new(disciplina_params)
    @cursos = Curso.all
    authorize(@disciplina)

    respond_to do |format|
      if @disciplina.save
        logtxt = "Disciplina " + @disciplina.nome_disciplina + " adicionada com sucesso."
        Rails.logger.info logtxt
        format.html { redirect_to disciplina_url(@disciplina), notice: logtxt }
        format.json { render :show, status: :created, location: @disciplina }
      else
			  Rails.logger.error "Houve um erro ao criar a disciplina " + @disciplina.nome_disciplina + "."
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @disciplina.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /disciplinas/1 or /disciplinas/1.json
  def update
    @disciplina = Disciplina.find(params[:id])
    @disciplina.banner.attach(params[:banner])

    respond_to do |format|
      if @disciplina.update(disciplina_params)
        logtxt = "Disciplina " + @disciplina.nome_disciplina + " atualizada com sucesso."
        Rails.logger.info logtxt
        format.html { redirect_to disciplina_url(@disciplina), notice: logtxt }
        format.json { render :show, status: :ok, location: @disciplina }
      else
			  Rails.logger.error "Houve um erro ao atualizar a disciplina " + @disciplina.nome_disciplina + "."
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @disciplina.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /disciplinas/1 or /disciplinas/1.json
  def destroy
    @disciplina.destroy

    respond_to do |format|
      logtxt = "Disciplina " + @disciplina.nome_disciplina + " deletada com sucesso."
      Rails.logger.info logtxt
      format.html { redirect_to disciplinas_url, notice: logtxt }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_disciplina
      @disciplina = Disciplina.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def disciplina_params
      params.require(:disciplina).permit(:nome_disciplina, :curso, :turma, :usuario, :banner, :sala_aula, :semestre)
    end
    
    def isUsuarioEstudante(usuario)
        Usuario.cargo_usuarios[usuario.cargo_usuario] > 2
    end
end
