# Preview all emails at http://localhost:3000/rails/mailers/agendamento_mailer
class AgendamentoMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/agendamento_mailer/agendamento_dia_mailer
  def agendamento_dia_email
    AgendamentoMailer.with(
      usuarios_list: Usuario.all,
      agendamento: Agendamento.find(1)
    ).agendamento_dia_email
  end
end
