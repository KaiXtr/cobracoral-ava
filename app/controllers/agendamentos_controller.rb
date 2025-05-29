class AgendamentosController < ApplicationController
    before_action :set_agendamento, only: %i[ show edit update destroy ]

    def index
        if !params[:dia] then
            dnow = DateTime.now.to_date
            redirect_to "/agendamentos/#{dnow.mday}/#{dnow.month}/#{dnow.year}"
        else
            @usuario = get_usuario_autenticado
            nomes_dias = [
                "Segunda", "Terça", "Quarta", "Quinta", "Sexta"
            ]

            @dias_semana = []
            @dia_atual = Date.new(params[:ano].to_i,params[:mes].to_i,params[:dia].to_i)
            @dia_ontem = @dia_atual.yesterday
            @dia_amanha = @dia_atual.tomorrow
            @estaNoCalendario = true

            for i in 0..4 do
                data_dia = "2025-05-#{26 + i}".to_date
                agendamentos_dia = Agendamento.where(data_inicio: data_dia)
                conteudos_dia = Conteudo.where(
                    data_vencimento: data_dia..data_dia.next
                )

                puts agendamentos_dia
                puts conteudos_dia

                @dias_semana.push({
                    nome_dia: "#{nomes_dias[i]}-feira",
                    data_dia: data_dia,
                    tarefas: agendamentos_dia + conteudos_dia
                })
            end

            @agendamentos = Agendamento.all

            Rails.logger.info "Acessando todos os agendamentos."
        end
    end

    def new
        @agendamento = Agendamento.new
        @edificios_select = LocalAgendamento.all.map{|l| l[:edificio]}.uniq        
        @locais_select = LocalAgendamento.all.map{|l| l[:local]}

        Rails.logger.info "Criando novo agendamento."
    end
    
    def create
        @usuario_autenticado = get_usuario_autenticado
        params[:agendamento][:usuario_id] = @usuario_autenticado.id

        if params["is-presencial"] then
            local = LocalAgendamento.find_by(
                edificio: params[:agendamento][:edificio],
                local: params[:agendamento][:local],
            )
            params[:agendamento][:local_agendamento_id] = local.id
        else
            params[:agendamento][:local_agendamento_id] = nil
        end

        if !params["is-o-dia-todo"] then
            params[:agendamento][:horario_inicio] = nil
            params[:agendamento][:horario_fim] = nil
        end

        @agendamento = Agendamento.new(agendamento_params)
        @agendamentos = Agendamento.all
        @dias_semana = []

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
