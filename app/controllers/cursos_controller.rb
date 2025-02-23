class CursosController < ApplicationController
	before_action :set_curso, only: %i[ show edit update destroy ]

	def index
		# Redirecionar usuário não autenticado
		@usuario = usuario_autenticado
		redirect_to '/entrar' unless @usuario

		@curso = Curso.new
		
		# Listar cursos de acordo com Coordenador(a)/Professor(a)
		if policy(@curso).index? then
			if policy(@curso).temCargoProfessor? then
				@cursos = Curso.joins(:disciplina).where(
					disciplina: { usuario_id: @usuario.id}
				)
				Rails.logger.info "Acessando todos os cursos do(a) professor(a) " + @usuario.nome_completo + "."
			else
				@cursos = Curso.all
				Rails.logger.info "Acessando todos os cursos do(a) coordenador(a) " + @usuario.nome_completo + "."
			end
		# Redirecionar estudantes para suas turmas
		else
			if @usuario then
				matricula = Matricula.find_by(usuario_id: @usuario.id)
				Rails.logger.info "Redirecionando estudante " + @usuario.nome_completo + " para sua turma."
				redirect_to turma_path(matricula.turma_id)
			end
		end
	end

	def show
		@usuario = usuario_autenticado
		@curso = Curso.find(params[:id])
		authorize(@curso)
		@coordenacao = Usuario.find(@curso.usuario_id)
		@turmas = Turma.where(curso_id: @curso.id)
		@disciplinas = Disciplina.where(curso_id: @curso.id)

		Rails.logger.info "Acessando curso " + @curso.nome_curso + "."
	end

	def new
		@curso = Curso.new
		authorize(@curso)
		@usuario = usuario_autenticado
		@coordenacao = usuario_autenticado

		Rails.logger.info "Criando novo curso."
	end

	def edit
		@curso = Curso.find(params[:id])
		authorize(@curso)
		@coordenacao = Usuario.find(@curso.usuario_id)
		@usuario = usuario_autenticado
		@turmas = Turma.where(curso_id: @curso.id)
		@disciplinas = Disciplina.where(curso_id: @curso.id)

		@turma_nova = Turma.new
		@disciplina_nova = Disciplina.new

		Rails.logger.info "Editando curso " + @curso.nome_curso + "."
	end

	def create
		@curso = Curso.new(curso_params)
		authorize(@curso)
		@curso.usuario_id = usuario_autenticado.id
	
		respond_to do |format|
		  if @curso.save
			logtxt = "Curso " + @curso.nome_curso + " adicionado com sucesso."
			Rails.logger.info logtxt
			format.html { redirect_to curso_url(@curso), notice: logtxt }
			format.json { render :show, status: :created, location: @curso }
		  else
			Rails.logger.error "Houve um erro ao criar o curso " + @curso.nome_curso + "."
			format.html { render :new, status: :unprocessable_entity }
			format.json { render json: @curso.errors, status: :unprocessable_entity }
		  end
		end
	end

	def update
		authorize(@curso)
		respond_to do |format|
		  if @curso.update(curso_params)
			logtxt = "Curso " + @curso.nome_curso + " atualizado com sucesso."
			Rails.logger.info logtxt
			format.html { redirect_to curso_url(@curso), notice: logtxt }
			format.json { render :show, status: :ok, location: @curso }
		  else
			Rails.logger.error "Houve um erro ao atualizar o curso " + @curso.nome_curso + "."
			format.html { render :edit, status: :unprocessable_entity }
			format.json { render json: @curso.errors, status: :unprocessable_entity }
		  end
		end
	end

	def destroy
		authorize(@curso)
		@curso.destroy
	
		respond_to do |format|
			logtxt = "Curso " + @curso.nome_curso + " deletado com sucesso."
			Rails.logger.info logtxt
			format.html { redirect_to curso_url, notice: logtxt }
			format.json { head :no_content }
		end
	end

	private
		def set_curso
			@curso = Curso.find(params[:id])
		end

		def curso_params
			params.require(:curso).permit(:nome_curso, :descricao)
		end
end