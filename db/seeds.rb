# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

PronomesUsuario.create(id: 1, enumPronomes: 'Ela/dela')
PronomesUsuario.create(id: 2, enumPronomes: 'Ele/dele')
PronomesUsuario.create(id: 3, enumPronomes: 'Elu/delu')

MatriculaCargo.create(id: 1,
    enumCargoFeminino: 'Coordenadora', enumCargoMasculino: 'Coordenador')
MatriculaCargo.create(id: 2,
    enumCargoFeminino: 'Professora', enumCargoMasculino: 'Professor')
MatriculaCargo.create(id: 3,
    enumCargoFeminino: 'Representante', enumCargoMasculino: 'Coordenador')
MatriculaCargo.create(id: 4,
    enumCargoFeminino: 'Estagiária', enumCargoMasculino: 'Estagiário')
MatriculaCargo.create(id: 5,
    enumCargoFeminino: 'Monitora', enumCargoMasculino: 'Monitor')
MatriculaCargo.create(id: 6,
    enumCargoFeminino: 'Estudante', enumCargoMasculino: 'Estudante')

Usuario.create(
    id: 1,
    pronomes_usuarios_id: 2,
    nome_completo: "Ewerton Matheus Bezerra Ramos",
    email: "ewerton.ramos@cobracoral.edu.br",
    telefone: "997773322",
    senha: "12345678",
    profile_pic: nil,
    biografia: 'Sou estudante de ciência da computação',
    lattes_id: '2274633017966563',
    orcid_id: '0009-0002-5894-0401'
)
Usuario.create(
    id: 2,
    pronomes_usuarios_id: 1,
    nome_completo: "Professora de autômatos",
    email: "professora.automatos@cobracoral.edu.br",
    telefone: "997773322",
    senha: "12345678",
    profile_pic: nil,
    biografia: nil,
    lattes_id: nil,
    orcid_id: nil
)
Usuario.create(
    id: 3,
    pronomes_usuarios_id: 2,
    nome_completo: "Professor de IHC",
    email: "professor.ihc@cobracoral.edu.br",
    telefone: "997773322",
    senha: "12345678",
    profile_pic: nil,
    biografia: nil,
    lattes_id: nil,
    orcid_id: nil
)
Usuario.create(
    id: 4,
    pronomes_usuarios_id: 1,
    nome_completo: "Professora de Design",
    email: "professora.design@cobracoral.edu.br",
    telefone: "997773322",
    senha: "12345678",
    profile_pic: nil,
    biografia: nil,
    lattes_id: nil,
    orcid_id: nil
)
Usuario.create(
    id: 5,
    pronomes_usuarios_id: 1,
    nome_completo: "Representante da turma CC2 Noturno",
    email: "representante.cc2n@cobracoral.edu.br",
    telefone: "997773322",
    senha: "12345678",
    profile_pic: nil,
    biografia: nil,
    lattes_id: nil,
    orcid_id: nil
)
Usuario.create(
    id: 6,
    pronomes_usuarios_id: 2,
    nome_completo: "Estagiário da turma CC2 Vespertino",
    email: "monitor.cc2v@cobracoral.edu.br",
    telefone: "997773322",
    senha: "12345678",
    profile_pic: nil,
    biografia: nil,
    lattes_id: nil,
    orcid_id: nil
)
Usuario.create(
    id: 7,
    pronomes_usuarios_id: 2,
    nome_completo: "Monitor da turma CC2 Vespertino",
    email: "monitor.cc2v@cobracoral.edu.br",
    telefone: "997773322",
    senha: "12345678",
    profile_pic: nil,
    biografia: nil,
    lattes_id: nil,
    orcid_id: nil
)
Usuario.create(
    id: 8,
    pronomes_usuarios_id: 3,
    nome_completo: "Representante da turma DG1 Diruno",
    email: "representante.dg1d@cobracoral.edu.br",
    telefone: "997773322",
    senha: "12345678",
    profile_pic: nil,
    biografia: nil,
    lattes_id: nil,
    orcid_id: nil
)
Usuario.create(
    id: 9,
    pronomes_usuarios_id: 1,
    nome_completo: "Coordenadora do curso de Ciência da Computação",
    email: "coordenadora.cc@cobracoral.edu.br",
    telefone: "997773322",
    senha: "12345678",
    profile_pic: nil,
    biografia: nil,
    lattes_id: nil,
    orcid_id: nil
)

Curso.create(
    id: 1,
    nome_curso: "Ciência da Computação",
    descricao: "Esta graduação é dedicada a formar e qualificar profissionais da área da tecnologia da informação."
)
Curso.create(
    id: 2,
    nome_curso: "Design Gráfico",
    descricao: "Esta graduação é dedicada a formar e qualificar profissionais da área do design e da tecnologia web."
)

TurnoTurma.create(id: 1, enumTurno: 'Diurno')
TurnoTurma.create(id: 2, enumTurno: 'Vespertino')
TurnoTurma.create(id: 3, enumTurno: 'Noturno')

ModalidadeTurma.create(id: 1, enumModalidade: 'Presencial')
ModalidadeTurma.create(id: 2, enumModalidade: 'À distância')

Turma.create(id: 1, curso_id: 1, turno_turma_id: 1,
    modalidade_turma_id: 1, nome_turma: 'CC1 Diurno', senha_acesso: '12345678')
Turma.create(id: 2, curso_id: 1, turno_turma_id: 3,
    modalidade_turma_id: 1, nome_turma: 'CC1 Noturno', senha_acesso: '12345678')
Turma.create(id: 3, curso_id: 1, turno_turma_id: 2,
    modalidade_turma_id: 1, nome_turma: 'CC2 Vespertino', senha_acesso: '12345678')
Turma.create(id: 4, curso_id: 1, turno_turma_id: 3,
    modalidade_turma_id: 1, nome_turma: 'CC2 Noturno', senha_acesso: '12345678')
Turma.create(id: 5, curso_id: 2, turno_turma_id: 1,
    modalidade_turma_id: 1, nome_turma: 'DG1 Diurno', senha_acesso: '12345678')
Turma.create(id: 6, curso_id: 2, turno_turma_id: 3,
    modalidade_turma_id: 1, nome_turma: 'DG1 Noturno', senha_acesso: '12345678')
Turma.create(id: 7, curso_id: 2, turno_turma_id: 2,
    modalidade_turma_id: 1, nome_turma: 'DG2 Vespertino', senha_acesso: '12345678')
Turma.create(id: 8, curso_id: 2, turno_turma_id: 3,
    modalidade_turma_id: 1, nome_turma: 'DG2 Noturno', senha_acesso: '12345678')

Matricula.create(usuario_id: 1, turma_id: 1, matricula_cargo_id: 6)
Matricula.create(usuario_id: 2, turma_id: 1, matricula_cargo_id: 2)
Matricula.create(usuario_id: 3, turma_id: 1, matricula_cargo_id: 2)
Matricula.create(usuario_id: 4, turma_id: 6, matricula_cargo_id: 2)
Matricula.create(usuario_id: 4, turma_id: 5, matricula_cargo_id: 2)
Matricula.create(usuario_id: 5, turma_id: 4, matricula_cargo_id: 3)
Matricula.create(usuario_id: 6, turma_id: 3, matricula_cargo_id: 4)
Matricula.create(usuario_id: 7, turma_id: 3, matricula_cargo_id: 5)
Matricula.create(usuario_id: 8, turma_id: 5, matricula_cargo_id: 3)

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

Conteudo.create(
    id: 1,
    unidade_disciplina_id: 1,
    nome_conteudo: 'Introdução à autômatos',
    url_conteudo: nil,
    data_liberacao: DateTime.now,
    data_vencimento: DateTime.now
)
Conteudo.create(
    id: 2,
    unidade_disciplina_id: 1,
    nome_conteudo: 'O que são autômatos?',
    url_conteudo: nil,
    data_liberacao: DateTime.now,
    data_vencimento: DateTime.now
)
Conteudo.create(
    id: 3,
    unidade_disciplina_id: 1,
    nome_conteudo: 'Vídeo: autômato de estado finito',
    url_conteudo: nil,
    data_liberacao: DateTime.now,
    data_vencimento: DateTime.now
)
Conteudo.create(
    id: 4,
    unidade_disciplina_id: 1,
    nome_conteudo: 'Exercício 1',
    url_conteudo: nil,
    data_liberacao: DateTime.now,
    data_vencimento: DateTime.now
)
Conteudo.create(
    id: 5,
    unidade_disciplina_id: 2,
    nome_conteudo: "Vídeo: Conway's Game of Life",
    url_conteudo: nil,
    data_liberacao: DateTime.now,
    data_vencimento: DateTime.now
)
Conteudo.create(
    id: 6,
    unidade_disciplina_id: 2,
    nome_conteudo: 'Exercício 2',
    url_conteudo: nil,
    data_liberacao: DateTime.now,
    data_vencimento: DateTime.now
)
Conteudo.create(
    id: 7,
    unidade_disciplina_id: 3,
    nome_conteudo: 'Introdução a IHC',
    url_conteudo: nil,
    data_liberacao: DateTime.now,
    data_vencimento: DateTime.now
)
Conteudo.create(
    id: 8,
    unidade_disciplina_id: 3,
    nome_conteudo: 'Exercício 1 IHC',
    url_conteudo: nil,
    data_liberacao: DateTime.now,
    data_vencimento: DateTime.now
)
Conteudo.create(
    id: 9,
    unidade_disciplina_id: 4,
    nome_conteudo: 'Introdução à design web',
    url_conteudo: nil,
    data_liberacao: DateTime.now,
    data_vencimento: DateTime.now
)