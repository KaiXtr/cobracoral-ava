class TurmasController < ApplicationController
	before_action :set_turma, only: %i[ show edit update destroy ]

	def index
		# Redirecionar usuário não autenticado
		@usuario_autenticado = usuario_autenticado
		redirect_to '/entrar' unless @usuario_autenticado

		@turmas = Turma.all
		@turma = Turma.find(1)
	end

	def show
		@usuario = usuario_autenticado
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

	def edit
		@turma = Turma.find(params[:id])
		authorize(@turma)

		@cursos = Curso.pluck(:nome_curso)
		@curso_turma = Curso.find(@turma.curso_id)
		@turno_turmas = TurnoTurma.all
		@modalidade_turmas = ModalidadeTurma.all

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
		authorize(@turma)
		@turno_turmas = TurnoTurma.all
		@modalidade_turmas = ModalidadeTurma.all

		# Verificando nível de acesso do usuário
		usuario = usuario_autenticado
		matricula = Matricula.find_by(usuario_id: usuario.id)

		# Se professor ou representante, apenas cursos onde está matriculado
		if matricula then
			matriculaCargo = MatriculaCargo.find(matricula.matricula_cargo_id)
			if matriculaCargo.id == 2 || matriculaCargo.id == 3 then
				turmas_matriculadas = Turma.joins(:matricula).where(
					matricula: { turma_id: matricula.id }
				)
				@cursos = Array.new

				# Adicionar cursos das turmas matriculadas do usuário
				for turma_matriculada in turmas_matriculadas do
					curso_da_turma = Curso.find(turma_matriculada.curso_id)
					@cursos.push(curso_da_turma)
				end
			# Se não tiver acesso, não listar cursos
			else
				@cursos = nil
			end
		# Se coordenador, apenas cursos onde coordena
		else
			@cursos = Curso.where(usuario_id: @usuario.id)
		end
	end

	def create
		@turma = Turma.new(turma_params)
		authorize(@turma)
	
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

	def update
	  respond_to do |format|
		if @turma.update(turma_params)
		  format.html {
			  redirect_to turma_url(@turma),
			  notice: "Todas as alterações foram salvas."
			}
		  format.json { render :show, status: :ok, location: @turma }
		else
		  format.html { render :edit, status: :unprocessable_entity }
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
			params.require(:turma).permit(:curso_id, :nome_turma, :turno_turma_id, :modalidade_turma_id)
		end
end
