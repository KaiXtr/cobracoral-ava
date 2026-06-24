class AgendamentoMailer < ApplicationMailer
  include AgendamentosHelper

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.agendamento_mailer.agendamento_dia_mailer.subject
  #
  def agendamento_dia_email
    @agendamento = params[:agendamento]
    @autor_agendamento = Usuario.find(@agendamento.usuario_id).nome_completo
    @data_hora_agendamento = formatar_data_hora_agendamento(@agendamento)
    @link_agendamento = "#{@mailer_host}/agendamentos/#{@agendamento.id}"

    usuarios_notificados = Array.new()
    params[:usuarios_list].each do |u|
      preferencias_usuario = PreferenciasUsuario.find_by(usuario_id: u.id)

      if preferencias_usuario.notificacao_agendamentos then
        usuarios_notificados.push(u)
      end
    end

    if usuarios_notificados.length > 0 then
      begin
        mail_usuarios = usuarios_notificados.collect(&:email).join(",")
        mail(
            to: mail_usuarios,
            subject: "Agendamento próximo: #{@agendamento.nome_agendamento}"
            )
        Rails.logger.info "[MAILER] Agendamento próximo notificado aos usuários #{mail_usuarios}."
      rescue Errno::ECONNREFUSED
        Rails.logger.error "[MAILER] O cliente de email não está disponível."
      end
    else
      Rails.logger.info "[MAILER] Nenhum usuário foi notificado."
    end
  end
end
