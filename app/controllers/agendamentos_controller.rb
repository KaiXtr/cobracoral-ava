class AgendamentosController < ApplicationController
    before_action :set_agendamento, only: %i[ show edit update destroy ]

    def index
        @agendamento = Agendamento.new
        @meses_ano = [
            "Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho",
            "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"
        ]
        @start_hora = 8

        if !params[:dia] then
            dnow = DateTime.now.to_date
            redirect_to "/agendamentos/#{dnow.mday}/#{dnow.month}/#{dnow.year}"
        else
            @usuario = get_usuario_autenticado
            nomes_dias = [
                "Domingo", "Segunda", "Terça", "Quarta", "Quinta", "Sexta", "Sábado"
            ]

            @dias_semana = []
            @dia_atual = Date.new(params[:ano].to_i,params[:mes].to_i,params[:dia].to_i)

            @dia_ontem = @dia_atual.yesterday
            while (@dia_ontem.wday != 0) do
                @dia_ontem = @dia_ontem.yesterday
            end

            @dia_amanha = @dia_atual.tomorrow
            while (@dia_amanha.wday != 0) do
                @dia_amanha = @dia_amanha.tomorrow
            end

            @estaNoCalendario = true
            data_semana = @dia_atual

            while (data_semana.wday != 0) do
                data_semana = data_semana.yesterday
            end

            data_dia = data_semana.yesterday

            for i in 0..6 do
                data_dia = data_dia.tomorrow
                agendamentos_dia = Agendamento.where(
                    data_inicio: data_dia,
                    horario_inicio: nil
                )
                conteudos_dia = Conteudo.where(
                    data_vencimento: data_dia..data_dia.next
                )
                
                nome_dia = nomes_dias[data_dia.wday]

                if data_dia.wday != 0 && data_dia.wday != 6 then
                    nome_dia += "-feira"
                end

                tarefas_buttons = Array.new()
                for hora in 0..7 do
                    time_start = Time.new(
                        data_dia.year, data_dia.month, data_dia.day,
                        8 + (hora * 2), 0
                    )
                    time_end = Time.new(
                        data_dia.year, data_dia.month, data_dia.day,
                        9 + (hora * 2), 59
                    )

                    agendamento_hora = Agendamento.where(
                        data_inicio: data_dia,
                        horario_inicio: time_start..time_end,
                    )
                    if agendamento_hora != nil && agendamento_hora.length > 0 then
                        tarefas_buttons.push(agendamento_hora)
                    else
                        tarefas_buttons.push(nil)
                    end
                end

                puts nome_dia
                puts tarefas_buttons

                @dias_semana.push({
                    nome_dia: nome_dia,
                    data_dia: data_dia,
                    tarefas_buttons: agendamentos_dia + tarefas_buttons
                })
            end

            @agendamentos = Agendamento.all

            Rails.logger.info "Acessando todos os agendamentos."
        end
    end

    def new
        @agendamento = Agendamento.new
        data_agendamento = Date.today
        hora_agendamento = nil

        if request.query_parameters['d'] then
            data_agendamento = Date.new(
                data_agendamento.year,
                data_agendamento.month,
                request.query_parameters['d'].to_i,
            )
        end
        if request.query_parameters['m'] then
            data_agendamento = Date.new(
                data_agendamento.year,
                request.query_parameters['m'].to_i,
                data_agendamento.mday,
            )
        end
        if request.query_parameters['y'] then
            data_agendamento = Date.new(
                request.query_parameters['y'].to_i,
                data_agendamento.month,
                data_agendamento.mday,
            )
        end
        if request.query_parameters['y'] then
            hora_agendamento = Time.new(
                data_agendamento.year,
                data_agendamento.month,
                data_agendamento.mday,
                request.query_parameters['h'].to_i,
                0, nil, nil
            )
        end

        @agendamento.data_inicio = data_agendamento
        @agendamento.data_fim = data_agendamento
        @agendamento.horario_inicio = hora_agendamento
        @agendamento.horario_fim = hora_agendamento

        @edificios_select = LocalAgendamento.all.map{|l| l[:edificio]}.uniq        
        @locais_select = LocalAgendamento.all.map{|l| l[:local]}

        Rails.logger.info "Criando novo agendamento."
    end

    def show
        @agendamento = Agendamento.find(params[:id])
        Rails.logger.info "Exibindo agendamento."
    end
    
    def create
        @usuario_autenticado = get_usuario_autenticado
        params[:agendamento][:usuario_id] = @usuario_autenticado.id

        @agendamento = Agendamento.new(agendamento_params)
        @agendamentos = Agendamento.all
        @dia_atual = DateTime.now.to_date
        @dias_semana = []
        @dia_ontem = @dia_atual.yesterday
        @dia_amanha = @dia_atual.tomorrow
        @estaNoCalendario = true
        no_errors = true

        if params["is-presencial"] then
            if params[:agendamento][:horario_inicio] == nil || params[:agendamento][:horario_fim] == nil then
                no_errors = false
                respond_to do |format|
                    logtxt = "Agendamentos presenciais precisam conter horários."
                    Rails.logger.error logtxt
                    format.html { render :index, status: :unprocessable_entity }
                    format.json { render json: logtxt, status: :unprocessable_entity }
                end
            end

            local = LocalAgendamento.find_by(
                edificio: params[:agendamento][:edificio],
                local: params[:agendamento][:local],
            )
            verificar_local = Agendamento.where(
                local_agendamento_id: local.id,
                data_inicio: params[:agendamento][:data_inicio],
                horario_inicio: params[:agendamento][:horario_inicio]
            )

            if verificar_local != nil || verificar_local.length > 0 then
                no_errors = false
                respond_to do |format|
                    logtxt = "A sala informada para o agendamento já se encontra ocupada neste mesmo horário e dia."
                    Rails.logger.error logtxt
                    format.html { render :index, status: :unprocessable_entity }
                    format.json { render json: logtxt, status: :unprocessable_entity }
                end
            else
                params[:agendamento][:local_agendamento_id] = local.id
            end
        else
            params[:agendamento][:local_agendamento_id] = nil
        end

        if !params["is-o-dia-todo"] then
            params[:agendamento][:horario_inicio] = nil
            params[:agendamento][:horario_fim] = nil
        end

        if no_errors then
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
