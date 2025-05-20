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

    usuarios_list = params[:usuarios_list]

    mail(
        to: Usuario.find(@mensagem.destinatario_id).email,
        subject: "Nova mensagem de " + @autor_mensagem
        )
  end
end
