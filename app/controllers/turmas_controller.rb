class TurmasController < ApplicationController
	before_action :redirecionar_nao_logado
	before_action :set_turma, only: %i[ show edit update destroy ]

	def index
		@turmas = Turma.all
		@turma = Turma.find(1)

		Rails.logger.info "Acessando todas as turmas"
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
			estudante = Usuario.find(matricula.usuario_id)
			cargo = UsuarioCargo.find(estudante.usuario_cargo_id)

			if cargo.id > 2 then
				@estudantes_turma.push(estudante)
			end
		end

		# Listas disciplinas de turma, turno e modalidades específicas
		matricula = Matricula.find_by(usuario_id: usuario_autenticado.id)
		if matricula then
			@disciplinas_turma = Disciplina.where(
				turma_id: @turma.id,
				semestre: matricula.semestre
			)
		else
			@disciplinas_turma = Disciplina.all
		end

		Rails.logger.info "Acessando turma " + @turma.nome_turma
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
			cargo = UsuarioCargo.find(usuario.usuario_cargo_id)
			estudante = Usuario.find(matricula.usuario_id)

			if cargo.id > 2 then
				@estudantes_turma.push(estudante)
			end
		end

		# Listas disciplinas de turma, turno e modalidades específicas
		@disciplinas_turma = Disciplina.where(
			turma_id: @turma.id
		)

		Rails.logger.info "Editando turma " + @turma.nome_turma
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
			usuarioCargo = UsuarioCargo.find(usuario.usuario_cargo_id)
			if usuarioCargo.id == 2 || usuarioCargo.id == 3 then
				turmas_matriculadas = Turma.joins(:matricula).where(
					matricula: { turma_id: matricula.id }
				)
				@cursos = Array.new

				# Adicionar cursos das turmas matriculadas do usuário
				for turma_matriculada in turmas_matriculadas do
					curso_da_turma = Curso.find(turma_matriculada.curso_id)
					@cursos.push(curso_da_turma)
				end
				Rails.logger.info "Criando nova turma com nível de usuário Professor(a)/Representante."
			# Se não tiver acesso, não listar cursos
			else
				@cursos = nil
				Rails.logger.warn "Usuário(a) não possui permissão para criar novas turmas."
			end
		# Se coordenador, apenas cursos onde coordena
		else
			@cursos = Curso.where(usuario_id: @usuario.id)
			Rails.logger.info "Criando nova turma com nível de usuário Coordenador(a)."
		end
	end

	def matricular
		@usuario = usuario_autenticado
		@turma = Turma.find(params[:id])
		
		if policy(@turma).matricular? then
			@estudantes_matriculados = Usuario.joins(:matricula).where(
				matricula: { turma_id: @turma.id }
			)
			@estudantes_nao_matriculados = Array.new
			for estudante in Usuario.all do
				if !estudante.in?(@estudantes_matriculados) then
					@estudantes_nao_matriculados.push(estudante)
				end
			end

			Rails.logger.info "Acessando matrículas da turma " + @turma.nome_turma + "."
		else
			Rails.logger.info "Usuário(a) não possui permissão para matricular estudantes."
			redirect_to root_path
		end
	end

	def delete
		@usuario = usuario_autenticado
		@turma = Turma.find(params[:id])

		Rails.logger.info "Deletando turma " + @turma.nome_turma + "."
	end

	def create
		@turma = Turma.new(turma_params)
		authorize(@turma)
	
		respond_to do |format|
		  if @turma.save
			logtxt = "Turma " + @turma.nome_turma + " adicionada com sucesso."
			Rails.logger.info logtxt
			format.html { redirect_to turma_url(@turma), notice: logtxt }
			format.json { render :show, status: :created, location: @turma }
		  else
			Rails.logger.error "Houve um erro ao criar a turma " + @turma.nome_turma + "."
			format.html { render :new, status: :unprocessable_entity }
			format.json { render json: @turma.errors, status: :unprocessable_entity }
		  end
		end
	end

	def update
	  respond_to do |format|
		if @turma.update(turma_params)
			logtxt = "Turma " + @turma.nome_turma + " atualizada com sucesso."
		  Rails.logger.info logtxt
		  format.html {
			  redirect_to turma_url(@turma),
			  notice: logtxt
			}
		  format.json { render :show, status: :ok, location: @turma }
		else
		  Rails.logger.error "Houve um erro ao criar a turma " + @turma.nome_turma + "."
		  format.html { render :edit, status: :unprocessable_entity }
		  format.json { render json: @turma.errors, status: :unprocessable_entity }
		end
	  end
	end

	def destroy
		@turma.destroy
	
		respond_to do |format|
			logtxt = "Turma " + @turma.nome_turma + " deletada com sucesso."
			Rails.logger.info logtxt
			format.html { redirect_to turma_url, notice: logtxt }
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
