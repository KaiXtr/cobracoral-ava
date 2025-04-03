# Preview all emails at http://localhost:3000/rails/mailers/session_mailer
class SessionMailerPreview < ActionMailer::Preview
    def primeiro_acesso_email
        usuario = Usuario.create(
            id: 1,
            pronomes_usuario: :ele_dele,
            nome_completo: "Ewerton Matheus Bezerra Ramos",
            email: "bramosewerton@proton.me",
            telefone: "997773322",
            password: "C0br@c0r@l",
            biografia: 'Sou estudante de ciência da computação',
            lattes_id: '2274633017966563',
            orcid_id: '0009-0002-5894-0401',
            cargo_usuario: :professor,
            acessos_count: 0
        )

		SessionMailer.with(
			usuario: usuario,
            instituicao_nome: "Instituto Cobracoral",
            senha_provisoria: usuario.password).primeiro_acesso_email
    end

    def acesso_email
        usuario = Usuario.create(
            id: 1,
            pronomes_usuario: :ele_dele,
            nome_completo: "Ewerton Matheus Bezerra Ramos",
            email: "bramosewerton@proton.me",
            telefone: "997773322",
            password: "C0br@c0r@l",
            biografia: 'Sou estudante de ciência da computação',
            lattes_id: '2274633017966563',
            orcid_id: '0009-0002-5894-0401',
            cargo_usuario: :estudante,
            acessos_count: 0
        )
		dispositivo_atual = "Lenovo legal"
		so_atual = "Fedora Workstation"
		browser_atual = "Firefox"
		hora_atual = Time.now

		SessionMailer.with(
			usuario: usuario,
			login_device: dispositivo_atual,
			login_so: so_atual,
			login_browser: browser_atual,
			login_time: hora_atual).acesso_email
    end
end
