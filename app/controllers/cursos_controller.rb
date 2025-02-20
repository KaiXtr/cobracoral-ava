class CursosController < ApplicationController
	before_action :set_curso, only: %i[ show edit update destroy ]

	def index
		# Redirecionar usuário não autenticado
		@usuario = usuario_autenticado
		redirect_to '/entrar' unless @usuario

		@curso = Curso.new
		@cursos = Curso.all
		authorize(@curso)
	end

	def show
		@usuario = usuario_autenticado
		@curso = Curso.find(params[:id])
		authorize(@curso)
		@turmas = Turma.where(curso_id: @curso.id)
		@disciplinas = Disciplina.where(curso_id: @curso.id)
	end

	def new
		@curso = Curso.new
		authorize(@curso)
		@usuario = usuario_autenticado
	end

	def edit
		@curso = Curso.find(params[:id])
		authorize(@curso)
		@usuario = usuario_autenticado
		@turmas = Turma.where(curso_id: @curso.id)
		@disciplinas = Disciplina.where(curso_id: @curso.id)

		@turma_nova = Turma.new
		@disciplina_nova = Disciplina.new
	end

	def create
		@curso = Curso.new(curso_params)
		authorize(@curso)
		@curso.usuario_id = usuario_autenticado.id
	
		respond_to do |format|
		  if @curso.save
			format.html {
				redirect_to curso_url(@curso),
				notice: "O curso " + @curso.nome_curso + " foi adicionado com sucesso."
			}
			format.json { render :show, status: :created, location: @curso }
		  else
			format.html { render :new, status: :unprocessable_entity }
			format.json { render json: @curso.errors, status: :unprocessable_entity }
		  end
		end
	end

	def update
		authorize(@curso)
		respond_to do |format|
		  if @curso.update(curso_params)
			format.html {
				redirect_to curso_url(@curso),
				notice: "Todas as alterações foram salvas."
			  }
			format.json { render :show, status: :ok, location: @curso }
		  else
			format.html { render :edit, status: :unprocessable_entity }
			format.json { render json: @curso.errors, status: :unprocessable_entity }
		  end
		end
	end

	def destroy
		authorize(@curso)
		@curso.destroy
	
		respond_to do |format|
		  format.html { redirect_to curso_url, notice: "Curso deletado com sucesso." }
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