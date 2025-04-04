# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Usuario.create(
    id: 1,
    pronomes_usuario: :ele_dele,
    nome_completo: "Ewerton Matheus Bezerra Ramos",
    email: "ewertonmatheus2113@gmail.com",
    telefone: "997773322",
    password: "C0br@c0r@l",
    biografia: 'Sou estudante de ciência da computação',
    lattes_id: '2274633017966563',
    orcid_id: '0009-0002-5894-0401',
    cargo_usuario: :estudante,
    acessos_count: 0
)
Usuario.create(
    id: 2,
    pronomes_usuario: :ela_dela,
    nome_completo: "Professora de autômatos",
    email: "professora.automatos@cobracoral.edu.br",
    telefone: "997773322",
    password: "C0br@c0r@l",
    biografia: nil,
    lattes_id: nil,
    orcid_id: nil,
    cargo_usuario: :professor,
    acessos_count: 0
)
Usuario.create(
    id: 3,
    pronomes_usuario: :ele_dele,
    nome_completo: "Professor de IHC",
    email: "professor.ihc@cobracoral.edu.br",
    telefone: "997773322",
    password: "C0br@c0r@l",
    biografia: nil,
    lattes_id: nil,
    orcid_id: nil,
    cargo_usuario: :professor,
    acessos_count: 0
)
Usuario.create(
    id: 4,
    pronomes_usuario: :ela_dela,
    nome_completo: "Professora de Design",
    email: "professora.design@cobracoral.edu.br",
    telefone: "997773322",
    password: "C0br@c0r@l",
    biografia: nil,
    lattes_id: nil,
    orcid_id: nil,
    cargo_usuario: :professor,
    acessos_count: 0
)
Usuario.create(
    id: 5,
    pronomes_usuario: :ela_dela,
    nome_completo: "Representante da turma CC2 Noturno",
    email: "representante.cc2n@cobracoral.edu.br",
    telefone: "997773322",
    password: "C0br@c0r@l",
    biografia: nil,
    lattes_id: nil,
    orcid_id: nil,
    cargo_usuario: :representante,
    acessos_count: 0
)
Usuario.create(
    id: 6,
    pronomes_usuario: :ele_dele,
    nome_completo: "Estagiário da turma CC2 Vespertino",
    email: "monitor.cc2v@cobracoral.edu.br",
    telefone: "997773322",
    password: "C0br@c0r@l",
    biografia: nil,
    lattes_id: nil,
    orcid_id: nil,
    cargo_usuario: :estagiario,
    acessos_count: 0
)
Usuario.create(
    id: 7,
    pronomes_usuario: :ele_dele,
    nome_completo: "Monitor da turma CC2 Vespertino",
    email: "monitor.cc2v@cobracoral.edu.br",
    telefone: "997773322",
    password: "C0br@c0r@l",
    biografia: nil,
    lattes_id: nil,
    orcid_id: nil,
    cargo_usuario: :monitor,
    acessos_count: 0
)
Usuario.create(
    id: 8,
    pronomes_usuario: :elu_delu,
    nome_completo: "Representante da turma DG1 Diruno",
    email: "representante.dg1d@cobracoral.edu.br",
    telefone: "997773322",
    password: "C0br@c0r@l",
    biografia: nil,
    lattes_id: nil,
    orcid_id: nil,
    cargo_usuario: :representante,
    acessos_count: 0
)
Usuario.create(
    id: 9,
    pronomes_usuario: :ela_dela,
    nome_completo: "Coordenadora do curso de Ciência da Computação",
    email: "coordenadora.cc@cobracoral.edu.br",
    telefone: "997773322",
    password: "C0br@c0r@l",
    biografia: nil,
    lattes_id: nil,
    orcid_id: nil,
    cargo_usuario: :coordenador,
    acessos_count: 0
)
Usuario.create(
    id: 10,
    pronomes_usuario: :ele_dele,
    nome_completo: "Coordenador do curso de Design Gráfico",
    email: "coordenador.dg@cobracoral.edu.br",
    telefone: "997773322",
    password: "C0br@c0r@l",
    biografia: nil,
    lattes_id: nil,
    orcid_id: nil,
    cargo_usuario: :coordenador,
    acessos_count: 0
)
Usuario.create(
    id: 11,
    pronomes_usuario: :ele_dele,
    nome_completo: "Administração do sistema",
    email: "administracao@cobracoral.edu.br",
    telefone: "997773322",
    password: "C0br@c0r@l",
    biografia: nil,
    lattes_id: nil,
    orcid_id: nil,
    cargo_usuario: :administrador,
    acessos_count: 0
)

puts "= usuarios populada."

Curso.create(
    id: 1,
    usuario_id: 9,
    nome_curso: "Ciência da Computação",
    descricao: "Esta graduação é dedicada a formar e qualificar profissionais da área da tecnologia da informação."
)
Curso.create(
    id: 2,
    usuario_id: 10,
    nome_curso: "Design Gráfico",
    descricao: "Esta graduação é dedicada a formar e qualificar profissionais da área do design e da tecnologia web."
)

puts "= cursos populada."

Turma.create(id: 1, curso_id: 1, turno_turma: :diurno,
    modalidade_turma: :presencial, nome_turma: 'CC1 Diurno', senha_acesso: '12345678')
Turma.create(id: 2, curso_id: 1, turno_turma: :noturno,
    modalidade_turma: :presencial, nome_turma: 'CC1 Noturno', senha_acesso: '12345678')
Turma.create(id: 3, curso_id: 1, turno_turma: :vespertino,
    modalidade_turma: :presencial, nome_turma: 'CC2 Vespertino', senha_acesso: '12345678')
Turma.create(id: 4, curso_id: 1, turno_turma: :noturno,
    modalidade_turma: :presencial, nome_turma: 'CC2 Noturno', senha_acesso: '12345678')
Turma.create(id: 5, curso_id: 2, turno_turma: :diurno,
    modalidade_turma: :ead, nome_turma: 'DG1 Diurno', senha_acesso: '12345678')
Turma.create(id: 6, curso_id: 2, turno_turma: :noturno,
    modalidade_turma: :ead, nome_turma: 'DG1 Noturno', senha_acesso: '12345678')
Turma.create(id: 7, curso_id: 2, turno_turma: :vespertino,
    modalidade_turma: :ead, nome_turma: 'DG2 Vespertino', senha_acesso: '12345678')
Turma.create(id: 8, curso_id: 2, turno_turma: :noturno,
    modalidade_turma: :ead, nome_turma: 'DG2 Noturno', senha_acesso: '12345678')

puts "= turmas populada."

Matricula.create(usuario_id: 1, turma_id: 1, semestre: '2025/1')
Matricula.create(usuario_id: 2, turma_id: 1, semestre: '2025/1')
Matricula.create(usuario_id: 3, turma_id: 1, semestre: '2025/1')
Matricula.create(usuario_id: 4, turma_id: 6, semestre: '2025/1')
Matricula.create(usuario_id: 4, turma_id: 5, semestre: '2025/1')
Matricula.create(usuario_id: 5, turma_id: 4, semestre: '2025/1')
Matricula.create(usuario_id: 6, turma_id: 3, semestre: '2025/1')
Matricula.create(usuario_id: 7, turma_id: 3, semestre: '2025/1')
Matricula.create(usuario_id: 8, turma_id: 5, semestre: '2025/1')

puts "= matriculas populada."

Disciplina.create(
    id: 1,
    curso_id: 1,
    turma_id: 1,
    usuario_id: 2,
    nome_disciplina: 'Teoria dos Autômatos',
    sala_aula: 'Bloco A Sala 202',
    semestre: '2025/1',
)
Disciplina.create(
    id: 2,
    curso_id: 1,
    turma_id: 1,
    usuario_id: 3,
    nome_disciplina: 'Interface Humano Computador',
    sala_aula: 'Bloco A Sala 204',
    semestre: '2025/2',
)
Disciplina.create(
    id: 3,
    curso_id: 2,
    turma_id: 6,
    usuario_id: 4,
    nome_disciplina: 'Design UI/UX',
    sala_aula: 'Bloco AC Sala 201',
    semestre: '2025/1',
)

puts "= disciplinas populada."

UnidadeDisciplina.create(
    id: 1,
    disciplina_id: 1,
    nome_unidade: 'Fundamentos de autômatos'
)
UnidadeDisciplina.create(
    id: 2,
    disciplina_id: 1,
    nome_unidade: 'Autômatos celulares'
)
UnidadeDisciplina.create(
    id: 3,
    disciplina_id: 2,
    nome_unidade: 'Fundamentos de IHC'
)
UnidadeDisciplina.create(
    id: 4,
    disciplina_id: 3,
    nome_unidade: 'Heurísticas de Nielsen'
)

puts "= unidade_disciplinas populada."

Conteudo.create(
    id: 1,
    unidade_disciplina_id: 1,
    nome_conteudo: 'Introdução à autômatos',
    data_liberacao: DateTime.now,
    data_vencimento: DateTime.now
)
Conteudo.create(
    id: 2,
    unidade_disciplina_id: 1,
    nome_conteudo: 'O que são autômatos?',
    data_liberacao: DateTime.now,
    data_vencimento: DateTime.now
)
Conteudo.create(
    id: 3,
    unidade_disciplina_id: 1,
    nome_conteudo: 'Vídeo: autômato de estado finito',
    data_liberacao: DateTime.now,
    data_vencimento: DateTime.now
)
Conteudo.create(
    id: 4,
    unidade_disciplina_id: 1,
    nome_conteudo: 'Exercício 1',
    data_liberacao: DateTime.now,
    data_vencimento: DateTime.now
)
Conteudo.create(
    id: 5,
    unidade_disciplina_id: 2,
    nome_conteudo: "Vídeo: Conway's Game of Life",
    data_liberacao: DateTime.now,
    data_vencimento: DateTime.now
)
Conteudo.create(
    id: 6,
    unidade_disciplina_id: 2,
    nome_conteudo: 'Exercício 2',
    data_liberacao: DateTime.now,
    data_vencimento: DateTime.now
)
Conteudo.create(
    id: 7,
    unidade_disciplina_id: 3,
    nome_conteudo: 'Introdução a IHC',
    data_liberacao: DateTime.now,
    data_vencimento: DateTime.now
)
Conteudo.create(
    id: 8,
    unidade_disciplina_id: 3,
    nome_conteudo: 'Exercício 1 IHC',
    data_liberacao: DateTime.now,
    data_vencimento: DateTime.now
)
Conteudo.create(
    id: 9,
    unidade_disciplina_id: 4,
    nome_conteudo: 'Introdução à design web',
    data_liberacao: DateTime.now,
    data_vencimento: DateTime.now
)

puts "= conteudos populada."

Comunicado.create(
    id: 1,
    usuario_id: 2,                           # Professora de autômatos
    turma_id: 1,                             # CC1 Diurno
    visibilidade_comunicado: :todos_turma    # Todos da turma
)
Comunicado.create(
    id: 2,
    usuario_id: 2,                           # Professora de autômatos
    turma_id: 2,                             # CC1 Noturno
    visibilidade_comunicado: :todos_turma    # Todos da turma
)
Comunicado.create(
    id: 3,
    usuario_id: 2,                           # Professora de autômatos
    turma_id: 1,                             # CC1 Diurno e Noturno
    visibilidade_comunicado: :todas_turmas   # Todas as turmas
)
Comunicado.create(
    id: 4,
    usuario_id: 4,                           # Professora de Design
    turma_id: 5,                             # DG1 Diurno
    visibilidade_comunicado: :todos_turma    # Todos da turma
)
Comunicado.create(
    id: 5,
    usuario_id: 4,                           # Professora de Design
    turma_id: 6,                             # DG1 Noturno
    visibilidade_comunicado: :todos_turma    # Todos da turma
)
Comunicado.create(
    id: 6,
    usuario_id: 4,                           # Professora de Design
    turma_id: 1,                             # DG1 Diurno e Noturno
    visibilidade_comunicado: :todas_turmas   # Todas as turmas
)
Comunicado.create(
    id: 7,
    usuario_id: 9,                           # Coordenadora do curso de ciência da computação
    turma_id: 1,                             # DG1 Diurno e Noturno
    visibilidade_comunicado: :todos_curso    # Todos do curso
)

puts "= comunicados populada."
