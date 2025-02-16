class TurmasController < ApplicationController
	before_action :set_turma, only: %i[ show edit update destroy ]

	def index
		# Redirecionar usuário não autenticado
		@usuario_autenticado = usuario_autenticado
		redirect_to '/entrar' unless @usuario_autenticado

		@turmas = Turma.all
	end

	def create
		@turma = Turma.new(turma_params)
	
		respond_to do |format|
		  if @turma.save
			format.html {
				redirect_to turma_url(@turma),
				notice: "A turma foi adicionada com sucesso."
			}
			format.json { render :show, status: :created, location: @turma }
		  else
			format.html { render :new, status: :unprocessable_entity }
			format.json { render json: @turma.errors, status: :unprocessable_entity }
		  end
		end
	end

	def show
		@turma = Turma.find(params[:id])
		@curso_turma = Curso.find(@turma.curso_id)
		@turno_turma = TurnoTurma.find(@turma.turno_turma_id)
		@modalidade_turma = ModalidadeTurma.find(@turma.modalidade_turma_id)
		
		@estudantes_turma = Usuario.joins(:matricula).where(
			matricula: { turma_id: @turma.id }
		)
		@disciplinas_turma = Disciplina.where(
			turma_id: @turma.id
		)
	end

	def destroy
		@turma.destroy
	
		respond_to do |format|
		  format.html { redirect_to turma_url, notice: "Turma deletada com sucesso." }
		  format.json { head :no_content }
		end
	end

	private

		def set_turma
			@turma = Turma.find(params[:id])
		end

		def turma_params
			params.require(:turma).permit(:nome_turma)
		end
end
