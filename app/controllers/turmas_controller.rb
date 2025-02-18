class TurmasController < ApplicationController
	before_action :set_turma, only: %i[ show edit update destroy ]

	def index
		# Redirecionar usuário não autenticado
		@usuario_autenticado = usuario_autenticado
		redirect_to '/entrar' unless @usuario_autenticado

		@turmas = Turma.all
	end

	def show
		@turma = Turma.find(params[:id])
		@curso_turma = Curso.find(@turma.curso_id)
		@turno_turma = TurnoTurma.find(@turma.turno_turma_id)
		@modalidade_turma = ModalidadeTurma.find(@turma.modalidade_turma_id)

		# Listar apenas usuários estudantes, excluindo professores
		@estudantes_turma = Array.new
		matriculas_estudantes = Matricula.where(turma_id: @turma.id)
		for matricula in matriculas_estudantes do
			cargo = MatriculaCargo.find(matricula.matricula_cargo_id)
			estudante = Usuario.find(matricula.usuario_id)

			if cargo.id > 2 then
				@estudantes_turma.push(estudante)
			end
		end

		# Listas disciplinas de turma, turno e modalidades específicas
		@disciplinas_turma = Disciplina.where(
			turma_id: @turma.id
		)
	end

	def new
		@turma = Turma.new
		@cursos = Curso.pluck(:nome_curso)
		@turno_turmas = TurnoTurma.pluck(:enumTurno)
		@modalidade_turmas = ModalidadeTurma.pluck(:enumModalidade)
	end

	def edit
		@turma = Turma.find(params[:id])
		@cursos = Curso.pluck(:nome_curso)
		@curso_turma = Curso.find(@turma.curso_id)
		@turno_turmas = TurnoTurma.pluck(:enumTurno)
		@modalidade_turmas = ModalidadeTurma.pluck(:enumModalidade)

		# Listar apenas usuários estudantes, excluindo professores
		@estudantes_turma = Array.new
		matriculas_estudantes = Matricula.where(turma_id: @turma.id)
		for matricula in matriculas_estudantes do
			cargo = MatriculaCargo.find(matricula.matricula_cargo_id)
			estudante = Usuario.find(matricula.usuario_id)

			if cargo.id > 2 then
				@estudantes_turma.push(estudante)
			end
		end

		# Listas disciplinas de turma, turno e modalidades específicas
		@disciplinas_turma = Disciplina.where(
			turma_id: @turma.id
		)
	end

	def create
		@turma = Turma.new(turma_params)
		@cursos = Curso.pluck(:nome_curso)
		@turno_turmas = TurnoTurma.pluck(:enumTurno)
		@modalidade_turmas = ModalidadeTurma.pluck(:enumModalidade)
	
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
