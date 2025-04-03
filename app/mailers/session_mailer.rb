class SessionMailer < ApplicationMailer
  default from: "ewertonmatheus2113@gmail.com"

    def acesso_email
        @usuario = params[:usuario]
        @login_device = params[:login_device]
        @login_so = params[:login_so]
        @login_browser = params[:login_browser]
        @login_time = params[:login_time]
        
        mail(to: @usuario.email, subject: "Novo acesso em " + @login_browser)
    end
end
