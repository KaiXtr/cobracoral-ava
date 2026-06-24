class AgendamentoDiaJob < ApplicationJob
  queue_as :default

  def perform(agendamento)
    usuario_agendamento = Usuario.find_by(id: agendamento.usuario_id)
    Rails.logger.info "[JOB] Notificando agendamento \"#{agendamento.nome_agendamento}\" ao usuário de email #{usuario_agendamento.email}."

    AgendamentoMailer.with(
      usuarios_list: [usuario_agendamento],
      agendamento: agendamento).agendamento_dia_email.deliver_later
  end
end
