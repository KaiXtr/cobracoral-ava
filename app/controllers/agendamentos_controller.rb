class AgendamentosController < ApplicationController
    before_action :set_agendamento, only: %i[ show edit update destroy ]

    def new
        @agendamento = Agendamento.new
        Rails.logger.info "Criando novo agendamento."
    end
    
    def create
        @usuario_autenticado = get_usuario_autenticado
        params[:agendamento][:usuario_id] = @usuario_autenticado.id
        params[:agendamento][:local_agendamento_id] = 1
        @agendamento = Agendamento.new(agendamento_params)

        respond_to do |format|
            if @agendamento.save
                logtxt = "Criado novo agendamento."
                Rails.logger.info logtxt
                format.html { redirect_to agendamentos_url, notice: logtxt }
                format.json { render :index, status: :created, location: @agendamento }
            else
                Rails.logger.error "Houve um erro ao criar o agendamento."
                Rails.logger.error @agendamento.errors
                format.html { render :index, status: :unprocessable_entity }
                format.json { render json: @agendamento.errors, status: :unprocessable_entity }
            end
        end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_agendamento
        @agendamento = Agendamento.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def agendamento_params
        params.require(:agendamento).permit(:nome_agendamento, :usuario_id, :local_agendamento_id, :data_inicio, :data_fim, :horario_inicio, :horario_fim, :repete)
      end
end
