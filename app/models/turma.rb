class Turma < ApplicationRecord
	after_create_commit { broadcast_append_to "turmas" }

    def exibir
        @usuario_atual = usuario_atual
        @turma_unica = Turma.find(params[:id])
        @turmas = Turmas
        @usuarios = Usuario.all_except(@usuario_atual)
        @turma = Turma.new
      
        render "index"
      end
end
