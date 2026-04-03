# Preview all emails at http://localhost:3000/rails/mailers/session_mailer
class SessionMailerPreview < ActionMailer::Preview
    def primeiro_acesso_email
        usuario = Usuario.find(1)
		SessionMailer.with(
			usuario: usuario,
            instituicao_nome: "Instituto Cobracoral",
            senha_provisoria: '1234ABC').primeiro_acesso_email
    end

    def acesso_email
		dispositivo_atual = "Lenovo legal"
		so_atual = "Fedora Workstation"
		browser_atual = "Firefox"
		hora_atual = Time.now

		SessionMailer.with(
			usuario: Usuario.find(1),
			login_device: dispositivo_atual,
			login_so: so_atual,
			login_browser: browser_atual,
			login_time: hora_atual).acesso_email
    end

    def recuperacao_senha_email
		dispositivo_atual = "Lenovo legal"
		so_atual = "Fedora Workstation"
		browser_atual = "Firefox"
		hora_atual = Time.now

		SessionMailer.with(
			usuario: Usuario.find(1),
			login_device: dispositivo_atual,
			login_so: so_atual,
			login_browser: browser_atual,
			login_time: hora_atual).recuperacao_senha_email
    end
end
