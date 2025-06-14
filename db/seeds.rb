# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Usuario.create([
	{
        id: 0,
        pronomes_usuario: :elu_delu,
        nome_completo: "Admin",
        email: "admin@cobracoral.edu.br",
        telefone: nil,
        password: "C0br@c0r@l",
        biografia: nil,
        lattes_id: nil,
        orcid_id: nil,
        cargo_usuario: :administrador,
        acessos_count: 0
    },
    {
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
    },
	{
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
    },
	{
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
    },
    {
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
    },
	{
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
    },
	{
        id: 6,
        pronomes_usuario: :ele_dele,
        nome_completo: "Estagiário da turma CC2 Vespertino",
        email: "estagiario.cc2v@cobracoral.edu.br",
        telefone: "997773322",
        password: "C0br@c0r@l",
        biografia: nil,
        lattes_id: nil,
        orcid_id: nil,
        cargo_usuario: :estagiario,
        acessos_count: 0
    },
	{
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
    },
	{
        id: 8,
        pronomes_usuario: :elu_delu,
        nome_completo: "Representante da turma DG1 Diurno",
        email: "representante.dg1d@cobracoral.edu.br",
        telefone: "997773322",
        password: "C0br@c0r@l",
        biografia: nil,
        lattes_id: nil,
        orcid_id: nil,
        cargo_usuario: :representante,
        acessos_count: 0
    },
	{
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
    },
	{
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
    },
	{
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
    },
	{
        id: 12,
        pronomes_usuario: :ela_dela,
        nome_completo: "Estudante da turma CC2 Vespertino",
        email: "estudante.cc2v@cobracoral.edu.br",
        telefone: "997773322",
        password: "C0br@c0r@l",
        biografia: nil,
        lattes_id: nil,
        orcid_id: nil,
        cargo_usuario: :estudante,
        acessos_count: 0
    }
])

puts "= usuarios populada."

for i in 0..12 do
    PreferenciasUsuario.create(
        id: i,
        usuario_id: i,
        idioma: "pt-BR",
        tema: "default",
        avaliacao_exibir_tempo: true,
        avaliacao_exibir_progresso: true,
        pomodoro_ativar: true,
        pomodoro_pomodoris_tempo: 25,
        pomodoro_descanso: 5,
        pomodoro_pomodoris_quant: 4,
        pomodoro_hibernar: true,
        pomodoro_logoff: false,
        notificacao_novo_acesso: true,
        notificacao_comunicados_coordenacao: true,
        notificacao_comunicados_turma: true,
        notificacao_agendamentos: true,
        notificacao_avaliacao_liberada: true,
        notificacao_conteudo_liberado: true,
        notificacao_nota_lancada: true,
        notificacao_nova_mensagem: true,
        notificacao_situacao_solicitacao: true
    )
end

puts "= preferencias_usuario populada."

Curso.create([
    {
        id: 1,
        usuario_id: 9,
        nome_curso: "Ciência da Computação",
        descricao: "Esta graduação é dedicada a formar e qualificar profissionais da área da tecnologia da informação."
    },
	{
        id: 2,
        usuario_id: 10,
        nome_curso: "Design Gráfico",
        descricao: "Esta graduação é dedicada a formar e qualificar profissionais da área do design e da tecnologia web."
    }
])

puts "= cursos populada."

Turma.create([
    {
        id: 1, curso_id: 1, turno_turma: :diurno,
        modalidade_turma: :presencial, nome_turma: 'CC1 Diurno', senha_acesso: '12345678'
    },
	{
        id: 2, curso_id: 1, turno_turma: :noturno,
        modalidade_turma: :presencial, nome_turma: 'CC1 Noturno', senha_acesso: '12345678'
    },
	{
        id: 3, curso_id: 1, turno_turma: :vespertino,
        modalidade_turma: :presencial, nome_turma: 'CC2 Vespertino', senha_acesso: '12345678'
    },
	{
        id: 4, curso_id: 1, turno_turma: :noturno,
        modalidade_turma: :presencial, nome_turma: 'CC2 Noturno', senha_acesso: '12345678'
    },
	{
        id: 5, curso_id: 2, turno_turma: :diurno,
        modalidade_turma: :ead, nome_turma: 'DG1 Diurno', senha_acesso: '12345678'
    },
	{
        id: 6, curso_id: 2, turno_turma: :noturno,
        modalidade_turma: :ead, nome_turma: 'DG1 Noturno', senha_acesso: '12345678'
    },
	{
        id: 7, curso_id: 2, turno_turma: :vespertino,
        modalidade_turma: :ead, nome_turma: 'DG2 Vespertino', senha_acesso: '12345678'
    },
	{
        id: 8, curso_id: 2, turno_turma: :noturno,
        modalidade_turma: :ead, nome_turma: 'DG2 Noturno', senha_acesso: '12345678'
    }
])

puts "= turmas populada."

LocalAgendamento.create([
    { id: 1, edificio: "Bloco X", local: "Sala 101" },
    { id: 2, edificio: "Bloco X", local: "Sala 102" },
    { id: 3, edificio: "Bloco X", local: "Sala 201" },
    { id: 4, edificio: "Bloco X", local: "Sala 202" },
    { id: 5, edificio: "Bloco Y", local: "Lab 1" },
    { id: 6, edificio: "Bloco Y", local: "Lab 2" },
    { id: 7, edificio: "Bloco Y", local: "Lab 3" },
    { id: 8, edificio: "Bloco Y", local: "Lab 4" },
])

puts "= locais de agendamentos populada."

Agendamento.create([
    {
        id: 1,
        usuario_id: 9,
        local_agendamento_id: nil,
        nome_agendamento: "Ano novo",
        data_inicio: "2025-01-01",
        data_fim: "2025-01-01",
        horario_inicio: nil,
        horario_fim: nil,
        repete: :todo_ano
    },
    {
        id: 2,
        usuario_id: 9,
        local_agendamento_id: nil,
        nome_agendamento: "Tiradentes",
        data_inicio: "2025-04-21",
        data_fim: "2025-04-21",
        horario_inicio: nil,
        horario_fim: nil,
        repete: :todo_ano
    },
    {
        id: 3,
        usuario_id: 9,
        local_agendamento_id: nil,
        nome_agendamento: "Dia do trabalho",
        data_inicio: "2025-05-01",
        data_fim: "2025-05-01",
        horario_inicio: nil,
        horario_fim: nil,
        repete: :todo_ano
    },
    {
        id: 4,
        usuario_id: 9,
        local_agendamento_id: nil,
        nome_agendamento: "Independência do Brasil",
        data_inicio: "2025-09-07",
        data_fim: "2025-09-07",
        horario_inicio: nil,
        horario_fim: nil,
        repete: :todo_ano
    },
    {
        id: 5,
        usuario_id: 9,
        local_agendamento_id: nil,
        nome_agendamento: "Dia de Finados",
        data_inicio: "2025-11-02",
        data_fim: "2025-11-02",
        horario_inicio: nil,
        horario_fim: nil,
        repete: :todo_ano
    },
    {
        id: 6,
        usuario_id: 9,
        local_agendamento_id: nil,
        nome_agendamento: "Proclamação da República",
        data_inicio: "2025-11-15",
        data_fim: "2025-11-15",
        horario_inicio: nil,
        horario_fim: nil,
        repete: :todo_ano
    },
    {
        id: 7,
        usuario_id: 9,
        local_agendamento_id: nil,
        nome_agendamento: "Natal",
        data_inicio: "2025-12-25",
        data_fim: "2025-12-25",
        horario_inicio: nil,
        horario_fim: nil,
        repete: :todo_ano
    },
])

puts "= agendamentos populada."

Matricula.create([
    { usuario_id: 1, turma_id: 1, semestre: '2025/1' },
    { usuario_id: 5, turma_id: 4, semestre: '2025/1' },
    { usuario_id: 6, turma_id: 3, semestre: '2025/1' },
    { usuario_id: 7, turma_id: 3, semestre: '2025/1' },
    { usuario_id: 8, turma_id: 5, semestre: '2025/1' },
    { usuario_id: 12, turma_id: 3, semestre: '2025/1' }
])

puts "= matriculas populada."

Disciplina.create([
    {
        id: 1,
        curso_id: 1,
        turma_id: 1,
        usuario_id: 2,
        nome_disciplina: 'Teoria dos Autômatos',
        sala_aula: 'Bloco A Sala 202',
        semestre: '2025/1',
    },
    {
        id: 2,
        curso_id: 1,
        turma_id: 1,
        usuario_id: 3,
        nome_disciplina: 'Interface Humano Computador',
        sala_aula: 'Bloco A Sala 204',
        semestre: '2025/2',
    },
    {
        id: 3,
        curso_id: 1,
        turma_id: 1,
        usuario_id: 9,
        nome_disciplina: 'Programação Orientada a Objetos',
        sala_aula: 'Bloco A Sala 204',
        semestre: '2025/2',
    },
    {
        id: 4,
        curso_id: 1,
        turma_id: 3,
        usuario_id: 9,
        nome_disciplina: 'Programação Orientada a Objetos',
        sala_aula: 'Bloco A Sala 204',
        semestre: '2025/2',
    },
    {
        id: 5,
        curso_id: 2,
        turma_id: 6,
        usuario_id: 4,
        nome_disciplina: 'Design UI/UX',
        sala_aula: 'Bloco AC Sala 201',
        semestre: '2025/1',
    },
    {
        id: 6,
        curso_id: 2,
        turma_id: 7,
        usuario_id: 4,
        nome_disciplina: 'Design UI/UX',
        sala_aula: 'Bloco AC Sala 201',
        semestre: '2025/1',
    },
    {
        id: 7,
        curso_id: 1,
        turma_id: 2,
        usuario_id: 2,
        nome_disciplina: 'Teoria dos Autômatos',
        sala_aula: 'Bloco A Sala 202',
        semestre: '2025/1',
    },
    {
        id: 8,
        curso_id: 2,
        turma_id: 5,
        usuario_id: 3,
        nome_disciplina: 'Interface Humano Computador',
        sala_aula: 'Bloco B Sala 204',
        semestre: '2025/2',
    }
])

puts "= disciplinas populada."

UnidadeDisciplina.create([
    {
        id: 1,
        disciplina_id: 1,
        nome_unidade: 'Fundamentos de autômatos'
    },
    {
        id: 2,
        disciplina_id: 1,
        nome_unidade: 'Autômatos celulares'
    },
    {
        id: 3,
        disciplina_id: 2,
        nome_unidade: 'Fundamentos de IHC'
    },
    {
        id: 4,
        disciplina_id: 3,
        nome_unidade: 'Heurísticas de Nielsen'
    }
])

puts "= unidade_disciplinas populada."

Conteudo.create([
    {
        id: 1,
        unidade_disciplina_id: 1,
        nome_conteudo: 'Introdução à autômatos',
        data_liberacao: DateTime.now,
        data_vencimento: DateTime.now
    },
    {
        id: 2,
        unidade_disciplina_id: 1,
        nome_conteudo: 'O que são autômatos?',
        data_liberacao: DateTime.now,
        data_vencimento: DateTime.now
    },
    {
        id: 3,
        unidade_disciplina_id: 1,
        nome_conteudo: 'Vídeo: autômato de estado finito',
        data_liberacao: DateTime.now,
        data_vencimento: DateTime.now
    },
    {
        id: 4,
        unidade_disciplina_id: 1,
        nome_conteudo: 'Exercício 1',
        data_liberacao: DateTime.now,
        data_vencimento: DateTime.now
    },
    {
        id: 5,
        unidade_disciplina_id: 2,
        nome_conteudo: "Vídeo: Conway's Game of Life",
        data_liberacao: DateTime.now,
        data_vencimento: DateTime.now
    },
    {
        id: 6,
        unidade_disciplina_id: 2,
        nome_conteudo: 'Exercício 2',
        data_liberacao: DateTime.now,
        data_vencimento: DateTime.now
    },
    {
        id: 7,
        unidade_disciplina_id: 3,
        nome_conteudo: 'Introdução a IHC',
        data_liberacao: DateTime.now,
        data_vencimento: DateTime.now
    },
    {
        id: 8,
        unidade_disciplina_id: 3,
        nome_conteudo: 'Exercício 1 IHC',
        data_liberacao: DateTime.now,
        data_vencimento: DateTime.now
    },
    {
        id: 9,
        unidade_disciplina_id: 4,
        nome_conteudo: 'Introdução à design web',
        data_liberacao: DateTime.now,
        data_vencimento: DateTime.now
    }
])

puts "= conteudos populada."

c = Comunicado.create(
    id: 1,
    usuario_id: 9,                             # Coordenadora do curso de ciência da computação
    turma_id: nil,                             # Nenhum
    disciplina_id: nil,                        # Nenhum
    visibilidade_comunicado: :todos_curso,     # Todos do curso
)
c.corpo.body = "Comunicado visível para <b>todos do curso.</b>"
c.save

c = Comunicado.create(
    id: 2,
    usuario_id: 9,                             # Coordenadora do curso de ciência da computação
    turma_id: nil,                             # CC1 Diurno e CC2 Vespertino
    disciplina_id: nil,                        # Nenhum
    visibilidade_comunicado: :todas_turmas     # Todas as turmas em que leciona
)
c.corpo.body = "Comunicado visível para as turmas <b>CC1 Diurno e CC2 Vespertino.</b>"
c.save

c = Comunicado.create(
    id: 3,
    usuario_id: 9,                             # Coordenadora do curso de ciência da computação
    turma_id: 1,                               # CC1 Diurno
    disciplina_id: nil,                        # Nenhum
    visibilidade_comunicado: :todos_turma      # Todos de uma turma X
)
c.corpo.body = "Comunicado visível para a turma <b>CC1 Diurno.</b>"
c.save

c = Comunicado.create(
    id: 4,
    usuario_id: 9,                             # Coordenadora do curso de ciência da computação
    turma_id: 3,                               # CC2 Vespertino
    disciplina_id: nil,                        # Nenhum
    visibilidade_comunicado: :todos_turma      # Todos de uma turma X
)
c.corpo.body = "Comunicado visível para a turma <b>CC2 Vespertino.</b>"
c.save

c = Comunicado.create(
    id: 5,
    usuario_id: 9,                             # Coordenadora do curso de ciência da computação
    turma_id: 1,                               # CC1 Diurno
    disciplina_id: 3,                          # Programação Orientada a Objetos (CC1 Diurno)
    visibilidade_comunicado: :todos_disciplina # Todos de uma disciplina X
)
c.corpo.body = "Comunicado visível para a disciplina <b>Programação Orientada a Objetos</b> da turma <b>CC1 Diurno</b>"
c.save

c = Comunicado.create(
    id: 6,
    usuario_id: 2,                             # Professora de Autômatos
    turma_id: nil,                             # CC1 Diurno e CC1 Noturno
    disciplina_id: nil,                        # Nenhum
    visibilidade_comunicado: :todas_turmas     # Todas as turmas em que leciona
)
c.corpo.body = "Comunicado visível para as turmas <b>CC1 Diurno e CC1 Noturno.</b>"
c.save

c = Comunicado.create(
    id: 7,
    usuario_id: 2,                             # Professora de Autômatos
    turma_id: 1,                               # CC1 Diurno
    disciplina_id: nil,                        # Nenhum
    visibilidade_comunicado: :todos_turma      # Todos de uma turma X
)
c.corpo.body = "Comunicado visível para a turma <b>CC1 Diurno.</b>"
c.save

c = Comunicado.create(
    id: 8,
    usuario_id: 2,                             # Professora de Autômatos
    turma_id: 2,                               # CC1 Noturno
    disciplina_id: nil,                        # Nenhum
    visibilidade_comunicado: :todos_turma      # Todos de uma turma X
)
c.corpo.body = "Comunicado visível para a turma <b>CC1 Noturno.</b>"
c.save

c = Comunicado.create(
    id: 9,
    usuario_id: 2,                             # Professora de Autômatos
    turma_id: 1,                               # CC1 Diurno
    disciplina_id: 1,                          # Teoria dos Autômatos (CC1 Diurno)
    visibilidade_comunicado: :todos_disciplina # Todos de uma disciplina X
)
c.corpo.body = "Comunicado visível para a disciplina <b>Teoria dos Autômatos</b> da turma <b>CC1 Diurno</b>"
c.save

c = Comunicado.create(
    id: 10,
    usuario_id: 3,                             # Professor de IHC
    turma_id: nil,                             # DG1 Diurno e DG1 Noturno
    disciplina_id: nil,                        # Nenhum
    visibilidade_comunicado: :todas_turmas     # Todas as turmas em que leciona
)
c.corpo.body = "Comunicado visível para as turmas <b>DG1 Diurno e DG1 Noturno.</b>"
c.save

c = Comunicado.create(
    id: 11,
    usuario_id: 3,                             # Professor de IHC
    turma_id: 5,                               # DG1 Diurno
    disciplina_id: nil,                        # Nenhum
    visibilidade_comunicado: :todos_turma      # Todos de uma turma X
)
c.corpo.body = "Comunicado visível para a turma <b>DG1 Diurno.</b>"
c.save

c = Comunicado.create(
    id: 12,
    usuario_id: 3,                             # Professor de IHC
    turma_id: 6,                               # DG1 Noturno
    disciplina_id: nil,                        # Nenhum
    visibilidade_comunicado: :todos_turma      # Todos de uma turma X
)
c.corpo.body = "Comunicado visível para a turma <b>DG1 Noturno.</b>"
c.save

c = Comunicado.create(
    id: 13,
    usuario_id: 3,                             # Professor de IHC
    turma_id: 5,                               # DG1 Diurno
    disciplina_id: 8,                          # Interface Humano Computador (DG1 Diurno)
    visibilidade_comunicado: :todos_disciplina # Todos de uma disciplina X
)
c.corpo.body = "Comunicado visível para a disciplina <b>Interface Humano Computador</b> da turma <b>DG1 Diurno</b>"
c.save

c = Comunicado.create(
    id: 14,
    usuario_id: 5,                             # Representante da turma CC2 Noturno
    turma_id: 4,                               # CC2 Noturno
    disciplina_id: nil,                        # Nenhum
    visibilidade_comunicado: :todos_turma      # Todos de uma turma X
)
c.corpo.body = "Comunicado visível para a turma <b>CC2 Noturno.</b>"
c.save

c = Comunicado.create(
    id: 15,
    usuario_id: 8,                             # Representante da turma DG1 Diurno
    turma_id: 5,                               # DG1 Diurno
    disciplina_id: nil,                        # Nenhum
    visibilidade_comunicado: :todos_disciplina # Todos de uma turma X
)
c.corpo.body = "Comunicado visível para a turma <b>DG1 Diurno.</b>"
c.save

puts "= comunicados populada."

for i in 1..5 do
    m = Mensagem.create(
        id: i,
        remetente_id: i,
        destinatario_id: i + 1,
        is_privada: true
    )
    m.corpo.body = "Hello World!"
    m.save
end

puts "= mensagens populada."

AssuntoSolicitacao.create(
    [
        {
            id: 1,
            enum_assunto: "denúncia"
        },
        {
            id: 2,
            enum_assunto: "atendimento psicopedagógico"
        },
        {
            id: 3,
            enum_assunto: "utilização sala de aula"
        },
        {
            id: 4,
            enum_assunto: "cadastro disciplina"
        },
        {
            id: 5,
            enum_assunto: "recuperação de senha"
        },
        {
            id: 6,
            enum_assunto: "Atividades complementares"
        }
    ]
)

puts "= assunto solicitação populada."

Solicitacao.create(
    [
        {
            id: 1,
            usuario_id: 2,
            assunto_solicitacoes_id: 1,
            situacao: "Deferida",
            observacoes: "Aquela"
        },
        {
            id: 2,
            usuario_id: 2,
            assunto_solicitacoes_id: 2,
            situacao: "Solicitada",
            observacoes: "Aquela"
        },
        {
            id: 3,
            usuario_id: 2,
            assunto_solicitacoes_id: 3,
            situacao: "Aguardando Resposta",
            observacoes: "Aquela"
        },
        {
            id: 4,
            usuario_id: 2,
            assunto_solicitacoes_id: 4,
            situacao: "Indeferida",
            observacoes: "Aquela"
        }
    ]
)

puts "= solicitações populada."

