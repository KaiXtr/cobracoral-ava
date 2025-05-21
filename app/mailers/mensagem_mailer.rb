class MensagemMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.mensagem_mailer.nova_mensagem_email.subject
  #
  def nova_mensagem_email
    @mensagem = params[:mensagem]
    @autor_mensagem = Usuario.find(@mensagem.remetente_id).nome_completo
    @link_mensagem = "http://localhost:3000/mensagens/" + @mensagem.remetente_id.to_s

    begin
      mail_usuario = Usuario.find(@mensagem.destinatario_id).email
      mail(
          to: mail_usuario,
          subject: "Nova mensagem de " + @autor_mensagem
          )
      Rails.logger.info "[MAILER] Nova mensagem notificada ao usuário #{mail_usuario}."
    rescue
      Rails.logger.error "[MAILER] O cliente de email não está disponível."
    end
  end
end
