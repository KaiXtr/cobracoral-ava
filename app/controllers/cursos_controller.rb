class CursosController < ApplicationController
	def index
		# Redirecionar usuário não autenticado
		@usuario_autenticado = usuario_atual
		redirect_to '/entrar' unless @usuario_autenticado

		@curso = Turma.new
	end

	def create
		@curso = Curso.create(nome_curso: params["curso"]["nome_curso"])
	end

	def show
		@curso = Curso.find(params[:id])
	end
end