# Preview all emails at http://localhost:3000/rails/mailers/mensagem_mailer
class MensagemMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/mensagem_mailer/nova_mensagem_email
  def nova_mensagem_email
    MensagemMailer.nova_mensagem_email
  end
end
