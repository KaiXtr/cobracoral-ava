class SessionMailer < ApplicationMailer
    def primeiro_acesso_email
        @usuario = params[:usuario]

        if (@usuario.pronomes_usuario == "ela_dela")
            hashFeminino = Usuario.cargo_usuario_feminino_strings.transform_keys(&:to_s)
            @cargo_usuario = hashFeminino[@usuario.cargo_usuario + '_feminino_string']
            @saudacao = "Prezada " + @cargo_usuario
        else
            hashMasculino = Usuario.cargo_usuario_masculino_strings.transform_keys(&:to_s)
            @cargo_usuario = hashMasculino[@usuario.cargo_usuario + '_masculino_string']
            @saudacao = "Prezado " + @cargo_usuario
        end

        @senha_provisoria = params[:senha_provisoria]
        @instituicao_nome = params[:instituicao_nome]
        @acesso_link = "https://cobracoral-ava.onrender.com/entrar"

        mail(to: @usuario.email, subject: "Primeiro acesso no AVA")
    end

    def acesso_email
        @usuario = params[:usuario]
        @login_device = params[:login_device]
        @login_so = params[:login_so]
        @login_browser = params[:login_browser]
        @login_time = params[:login_time].strftime("%d/%m/%Y às %H:%M")
        
        mail(to: @usuario.email, subject: "Novo acesso em " + @login_browser)
    end

    def recuperacao_senha_email
        @usuario = params[:usuario]
        @login_device = params[:login_device]
        @login_so = params[:login_so]
        @login_browser = params[:login_browser]
        @login_time = params[:login_time].strftime("%d/%m/%Y às %H:%M")

        hash_senha = @usuario.password_digest

        @link_recuperacao = "http://localhost:3000/recuperar?h=" + hash_senha
        
        mail(to: @usuario.email, subject: "Recuperação de senha solicitada para " + @usuario.email)
    end
end
