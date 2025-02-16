# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Usuario.create(
    id: 1,
    nome_completo: "Ewerton Matheus Bezerra Ramos",
    email: "ewerton.ramos@cobracoral.edu.br",
    telefone: "997773322",
    senha: "12345678"
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

Turma.create(id: 1, curso_id: 1, nome_turma: 'CC1 Vespertino')
Turma.create(id: 2, curso_id: 1, nome_turma: 'CC1 Noturno')
Turma.create(id: 3, curso_id: 1, nome_turma: 'CC2 Vespertino')
Turma.create(id: 4, curso_id: 1, nome_turma: 'CC2 Noturno')
Turma.create(id: 5, curso_id: 2, nome_turma: 'DG1 Vespertino')
Turma.create(id: 6, curso_id: 2, nome_turma: 'DG1 Noturno')
Turma.create(id: 7, curso_id: 2, nome_turma: 'DG2 Vespertino')
Turma.create(id: 8, curso_id: 2, nome_turma: 'DG2 Noturno')

Disciplina.create(
    id: 1,
    curso_id: 1,
    nome_disciplina: 'Teoria dos Autômatos',
    semestre: '2025/1',
)
Disciplina.create(
    id: 2,
    curso_id: 1,
    nome_disciplina: 'Interface Humano Computador',
    semestre: '2025/2',
)
Disciplina.create(
    id: 3,
    curso_id: 2,
    nome_disciplina: 'Design UI/UX',
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