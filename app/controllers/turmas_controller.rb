class TurmasController < ApplicationController
	before_action :set_turma, only: %i[ show edit update destroy ]

	def index
		# Redirecionar usuário não autenticado
		@usuario_autenticado = usuario_autenticado
		redirect_to '/entrar' unless @usuario_autenticado

		@turmas = Turma.all
	end

	def create
		@turma = Turma.create(nome_turma: params["turma"]["nome_turma"])
	end

	def show
		@turma = Turma.find(params[:id])
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
end
