class CursosController < ApplicationController
	def index
		# Redirecionar usuário não autenticado
		@usuario_autenticado = usuario_autenticado
		redirect_to '/entrar' unless @usuario_autenticado

		@curso = Curso.new
		@cursos = Curso.all
	end

	def create
		@curso = Curso.create(nome_curso: params["curso"]["nome_curso"])
	end

	def show
		@curso = Curso.find(params[:id])
		@turmas = Turma.all
		@disciplinas = Disciplina.all
	end

	def edit
		@curso = Curso.find(params[:id])
		@turmas = Turma.all
		@disciplinas = Disciplina.all
	end
end