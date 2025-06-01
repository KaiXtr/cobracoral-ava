# Preview all emails at http://localhost:3000/rails/mailers/comunicado_mailer
class ComunicadoMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/comunicado_mailer/novo_comunicado_email
  def novo_comunicado_email
    ComunicadoMailer.with(
      usuarios_list: Usuario.all,
      comunicado: Comunicado.find(1)).novo_comunicado_email
  end
end
