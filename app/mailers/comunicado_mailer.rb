class ComunicadoMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.comunicado_mailer.novo_comunicado_email.subject
  #
  def novo_comunicado_email
    @comunicado = params[:comunicado]
    @autor_comunicado = Usuario.find(@comunicado.usuario_id).nome_completo
    @link_comunicado = "http://localhost:3000/comunicados#c" + @comunicado.id.to_s

    usuarios_list = params[:usuarios_list]

    mail(
        to: usuarios_list,
        subject: "Novo comunicado de " + @autor_comunicado
        )
  end
end
