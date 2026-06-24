class PreferenciasUsuarioController < ApplicationController
    def update
        @preferencias_usuario = PreferenciasUsuario.find(params[:id])

        respond_to do |format|
            if @preferencias_usuario.update(preferencias_usuario_params)
                logtxt = "Preferências de usuário atualizadas com sucesso."
                Rails.logger.info logtxt
                format.html { redirect_to root_path, notice: logtxt }
                format.json { render :show, status: :ok, location: @usuario }
            else
                Rails.logger.error "Houve um erro ao atualizar as preferências de usuário."
                Rails.logger.error @preferencias_usuario.errors
                format.html { render :edit, status: :unprocessable_entity }
                format.json { render json: @preferencias_usuario.errors, status: :unprocessable_entity }
            end
        end
    end

    private

        def preferencias_usuario_params
            params.require(:preferencias_usuario).permit(
                :idioma, :tema, :avaliacao_exibir_tempo, :avaliacao_exibir_progresso,
                :pomodoro_ativar, :pomodoro_pomodoris_tempo, :pomodoro_descanso,
                :pomodoro_pomodoris_quant, :pomodoro_hibernar, :pomodoro_logoff,
                :notificacao_novo_acesso, :notificacao_comunicados_coordenacao,
                :notificacao_comunicados_turma, :notificacao_agendamentos,
                :notificacao_avaliacao_liberada, :notificacao_conteudo_liberado,
                :notificacao_nota_lancada, :notificacao_nova_mensagem,
                :notificacao_situacao_solicitacao
            )
        end
end
