# Preview all emails at http://localhost:3000/rails/mailers/comunicado_mailer
class ComunicadoMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/comunicado_mailer/novo_comunicado_email
  def novo_comunicado_email
    
    usuario = Usuario.create(
        id: 1,
        pronomes_usuario: :ele_dele,
        nome_completo: "Ewerton Matheus Bezerra Ramos",
        email: "bramosewerton@proton.me",
        telefone: nil,
        password: "C0br@c0r@l",
        biografia: nil,
        lattes_id: nil,
        orcid_id: nil,
        cargo_usuario: :estudante,
        acessos_count: 0
    )

    comunicado_novo = Comunicado.create(
      id: 1,
      usuario_id: usuario.id,
      turma_id: nil,
      visibilidade_comunicado: :todos_curso
    )
    comunicado_novo.corpo.body = "<b>Hello World!</b> Como estão?"

    ComunicadoMailer.with(
      usuarios_list: [
        "ewertonmatheus2113@gmail.com",
        "professora.automatos@cobracoral.edu.br"
      ],
      comunicado: comunicado_novo).novo_comunicado_email
  end
end
