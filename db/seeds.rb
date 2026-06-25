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

Semestre.create([
    {
        id: 1,
        nome_semestre: '2026/1',
        dia_inicio: Time.now,
        dia_fim: Time.now
    }
])

puts "= semestres populada."

Turma.create([
    {
        id: 1, curso_id: 1, turno_turma: :diurno, semestre_id: 1,
        modalidade_turma: :presencial, nome_turma: 'CC1 Diurno', senha_acesso: '12345678'
    },
	{
        id: 2, curso_id: 1, turno_turma: :noturno, semestre_id: 1,
        modalidade_turma: :presencial, nome_turma: 'CC1 Noturno', senha_acesso: '12345678'
    },
	{
        id: 3, curso_id: 1, turno_turma: :vespertino, semestre_id: 1,
        modalidade_turma: :presencial, nome_turma: 'CC2 Vespertino', senha_acesso: '12345678'
    },
	{
        id: 4, curso_id: 1, turno_turma: :noturno, semestre_id: 1,
        modalidade_turma: :presencial, nome_turma: 'CC2 Noturno', senha_acesso: '12345678'
    },
	{
        id: 5, curso_id: 2, turno_turma: :diurno, semestre_id: 1,
        modalidade_turma: :ead, nome_turma: 'DG1 Diurno', senha_acesso: '12345678'
    },
	{
        id: 6, curso_id: 2, turno_turma: :noturno, semestre_id: 1,
        modalidade_turma: :ead, nome_turma: 'DG1 Noturno', senha_acesso: '12345678'
    },
	{
        id: 7, curso_id: 2, turno_turma: :vespertino, semestre_id: 1,
        modalidade_turma: :ead, nome_turma: 'DG2 Vespertino', senha_acesso: '12345678'
    },
	{
        id: 8, curso_id: 2, turno_turma: :noturno, semestre_id: 1,
        modalidade_turma: :ead, nome_turma: 'DG2 Noturno', senha_acesso: '12345678'
    }
])

puts "= turmas populada."

Matricula.create([
    { usuario_id: 1, turma_id: 1, semestre_id: 1 },
    { usuario_id: 5, turma_id: 4, semestre_id: 1 },
    { usuario_id: 6, turma_id: 3, semestre_id: 1 },
    { usuario_id: 7, turma_id: 3, semestre_id: 1 },
    { usuario_id: 8, turma_id: 5, semestre_id: 1 },
    { usuario_id: 12, turma_id: 3, semestre_id: 1 }
])

puts "= matriculas populada."

MatrizCurricular.create([
    {
        id: 1,
        curso_id: 1,
        nome_matriz: 'Ciência da Computação'
    },
    {
        id: 2,
        curso_id: 2,
        nome_matriz: 'Design Gráfico' 
    }
])

puts "= matriz curricular populada."

Ementa.create([
    {
        id: 1,
        semestre_id: 1,
        matriz_curricular_id: 1,
        nome_ementa: 'Teoria dos Autômatos',
        carga_horaria: 48,
        objetivos: 'Introduzir conceitos de autômatos e linguagens formais.',
        metodologia: 'Conteúdo didático, exercícios práticos, simuladores virtuais e prolog.'
    },
    {
        id: 2,
        semestre_id: 1,
        matriz_curricular_id: 1,
        nome_ementa: 'Interface Humano Computador',
        carga_horaria: 48,
        objetivos: 'Introduzir conceitos de IHC, design, psciologia gestáltica e ergonomia.',
        metodologia: 'Conteúdo didático, exercícios práticos e Figma.'
    },
    {
        id: 3,
        semestre_id: 1,
        matriz_curricular_id: 1,
        nome_ementa: 'Programação Orientada a Objetos',
        carga_horaria: 48,
        objetivos: 'Introduzir conceitos de programação orientada a objetos em Java.',
        metodologia: 'Conteúdo didático, exercícios práticos, Visual Studio Code e Eclipse.'
    },
    {
        id: 4,
        semestre_id: 1,
        matriz_curricular_id: 2,
        nome_ementa: 'Design UI/UX',
        carga_horaria: 48,
        objetivos: 'Introduzir conceitos de cores, tipografia e formatos de arquivos de áudio, vídeo e imagem.',
        metodologia: 'Conteúdo didático, exercícios práticos, Canva e Figma.'
    }
])

puts "= ementas populada."

Disciplina.create([
    { id: 1, curso_id: 1, turma_id: 1, ementa_id: 1, usuario_id: 2, semestre_id: 1, sala_aula: 'Bloco A Sala 202' },
    { id: 2, curso_id: 1, turma_id: 1, ementa_id: 2, usuario_id: 3, semestre_id: 1, sala_aula: 'Bloco A Sala 204' },
    { id: 3, curso_id: 1, turma_id: 1, ementa_id: 3, usuario_id: 9, semestre_id: 1, sala_aula: 'Bloco A Sala 204' },
    { id: 4, curso_id: 1, turma_id: 3, ementa_id: 3, usuario_id: 9, semestre_id: 1, sala_aula: 'Bloco A Sala 204' },
    { id: 5, curso_id: 2, turma_id: 6, ementa_id: 4, usuario_id: 4, semestre_id: 1, sala_aula: 'Bloco AC Sala 201' },
    { id: 6, curso_id: 2, turma_id: 7, ementa_id: 4, usuario_id: 4, semestre_id: 1, sala_aula: 'Bloco AC Sala 201' },
    { id: 7, curso_id: 1, turma_id: 2, ementa_id: 1, usuario_id: 2, semestre_id: 1, sala_aula: 'Bloco A Sala 202' },
    { id: 8, curso_id: 2, turma_id: 5, ementa_id: 2, usuario_id: 3, semestre_id: 1, sala_aula: 'Bloco B Sala 204' }
])

puts "= disciplinas populada."

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
        data_inicio: "2026-01-01",
        data_fim: "2026-01-01",
        horario_inicio: nil,
        horario_fim: nil,
        repete: :todo_ano
    },
    {
        id: 2,
        usuario_id: 9,
        local_agendamento_id: nil,
        nome_agendamento: "Tiradentes",
        data_inicio: "2026-04-21",
        data_fim: "2026-04-21",
        horario_inicio: nil,
        horario_fim: nil,
        repete: :todo_ano
    },
    {
        id: 3,
        usuario_id: 9,
        local_agendamento_id: nil,
        nome_agendamento: "Dia do trabalho",
        data_inicio: "2026-05-01",
        data_fim: "2026-05-01",
        horario_inicio: nil,
        horario_fim: nil,
        repete: :todo_ano
    },
    {
        id: 4,
        usuario_id: 9,
        local_agendamento_id: nil,
        nome_agendamento: "Independência do Brasil",
        data_inicio: "2026-09-07",
        data_fim: "2026-09-07",
        horario_inicio: nil,
        horario_fim: nil,
        repete: :todo_ano
    },
    {
        id: 5,
        usuario_id: 9,
        local_agendamento_id: nil,
        nome_agendamento: "Dia de Finados",
        data_inicio: "2026-11-02",
        data_fim: "2026-11-02",
        horario_inicio: nil,
        horario_fim: nil,
        repete: :todo_ano
    },
    {
        id: 6,
        usuario_id: 9,
        local_agendamento_id: nil,
        nome_agendamento: "Proclamação da República",
        data_inicio: "2026-11-15",
        data_fim: "2026-11-15",
        horario_inicio: nil,
        horario_fim: nil,
        repete: :todo_ano
    },
    {
        id: 7,
        usuario_id: 9,
        local_agendamento_id: nil,
        nome_agendamento: "Natal",
        data_inicio: "2026-12-25",
        data_fim: "2026-12-25",
        horario_inicio: nil,
        horario_fim: nil,
        repete: :todo_ano
    },
    {
        id: 8,
        usuario_id: 3,
        local_agendamento_id: 3,
        nome_agendamento: "Interface Humano Computador",
        data_inicio: "2026-03-06",
        data_fim: "2026-07-05",
        horario_inicio: "08:30",
        horario_fim: "12:15",
        repete: :toda_semana
    },
])

puts "= agendamentos populada."

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

a = Avaliacao.create(
    id: 1,
    unidade_disciplina_id: 1,
    nome_avaliacao: 'Avaliação I',
    nota_total: 30,
    data_liberacao: DateTime.now,
    data_vencimento: DateTime.now,
    tempo_limite: 60,
    quant_questoes: 5,
    quant_tentativas: 2,
    is_recuperacao: false
)
a.corpo.body = "Este é um exercício de resumo para a prova da semana que vem, valendo ponto."
a.save

a = Avaliacao.create(
    id: 2,
    unidade_disciplina_id: 2,
    nome_avaliacao: 'Avaliação II',
    nota_total: 50,
    data_liberacao: DateTime.now,
    data_vencimento: DateTime.now,
    tempo_limite: 60,
    quant_questoes: 5,
    quant_tentativas: 2,
    is_recuperacao: false
)
a.corpo.body = "Esta é a avaliação final desta disciplina."
a.save

puts "= avaliacoes populada."

q = QuestaoAvaliacao.create( id: 1, avaliacao_id: 1, peso_questao: 1 )
q.corpo_questao.body = "Qual o nome do matemático que descobriu a Máquina de Turing?"
q.save

q = QuestaoAvaliacao.create( id: 2, avaliacao_id: 1, peso_questao: 1 )
q.corpo_questao.body = "Por que o problema da decisão, conhecido como <b>entscheidungsproblem</b>, é considerado não computável?"
q.save

q = QuestaoAvaliacao.create( id: 3, avaliacao_id: 1, peso_questao: 1 )
q.corpo_questao.body = "O problema da parada, conhecido como <b>halting problem</b>, é considerado um problema:"
q.save

q = QuestaoAvaliacao.create( id: 4, avaliacao_id: 1, peso_questao: 1 )
q.corpo_questao.body = "De que forma a parábola do quarto chinês de John Searle se relaciona com o jogo da imitação de Alan Turing?"
q.save

q = QuestaoAvaliacao.create( id: 5, avaliacao_id: 1, peso_questao: 1 )
q.corpo_questao.body = "Qual é a relação entre o Teorema da Incompletude de Gödel e o conceito de Máquina Universal de Turing?"
q.save

q = QuestaoAvaliacao.create( id: 6, avaliacao_id: 2, peso_questao: 1 )
q.corpo_questao.body = "Marque duas alternativas que apresentam autômatos finitos determinísticos"
q.save

q = QuestaoAvaliacao.create( id: 7, avaliacao_id: 2, peso_questao: 1 )
q.corpo_questao.body = "Qual o tipo correspondente de linguagem associado aos autômatos de pilha?"
q.save

q = QuestaoAvaliacao.create( id: 8, avaliacao_id: 2, peso_questao: 1 )
q.corpo_questao.body = "É possível construir um algoritmo que descubra se uma equação diofantina possui solução?"
q.save

q = QuestaoAvaliacao.create( id: 9, avaliacao_id: 2, peso_questao: 1 )
q.corpo_questao.body = "Qual o nome do sistema de funções recursivas computáveis descoberto por Alonzo Church?"
q.save

q = QuestaoAvaliacao.create( id: 10, avaliacao_id: 2, peso_questao: 1 )
q.corpo_questao.body = "Em qual ano foi publicada a tese de Church-Turing?"
q.save

puts "= questao avaliacoes populada."

a = AlternativaQuestao.create(id: 1, questao_avaliacao_id: 1, is_correta: false )
a.label_alternativa.body = "Kurt Gödel"
a.explicacao_alternativa.body = "Kurt Gödel não descobriu a máquina de Turing, mas formulou o Teorema da Incompletude de Gödel, importante para a elaboração da tese de Church-Turing e a resolução do problema nº10 de David Hilbert."
a.save

a = AlternativaQuestao.create(id: 2, questao_avaliacao_id: 1, is_correta: false )
a.label_alternativa.body = "John Von Neumann"
a.explicacao_alternativa.body = "John Von Neumann não descobriu a máquina de Turing, mas elaborou o modelo de Von Neumann, crucial para padronizar a construção de computadores práticos reais."
a.save

a = AlternativaQuestao.create(id: 3, questao_avaliacao_id: 1, is_correta: true )
a.label_alternativa.body = "Alan Turing"
a.explicacao_alternativa.body = "Alan Turing foi o responsável por desenvolver a tese de Church-Turing, junto de Alonzo Church, em 1936, onde são relacionados a máquina de Turing e o cálculo lambda."
a.save

a = AlternativaQuestao.create(id: 4, questao_avaliacao_id: 1, is_correta: false )
a.label_alternativa.body = "David Hilbert"
a.explicacao_alternativa.body = "David Hilbert não descobriu a máquina de Turing, mas apresentou o problema nº10, que seria posteriormente resolvido pela tese de Church-Turing."
a.save

a = AlternativaQuestao.create(id: 5, questao_avaliacao_id: 1, is_correta: false )
a.label_alternativa.body = "Alonzo Church"
a.explicacao_alternativa.body = "Alonzo Church descobriu o cálculo lambda, também presente na tese de Church-Turing, mas não descobriu a máquina de Turing."
a.save

a = AlternativaQuestao.create(id: 6, questao_avaliacao_id: 2, is_correta: false )
a.label_alternativa.body = "Porque exige uma quantidade infinita de memória para ser resolvido por qualquer computador real"
a.explicacao_alternativa.body = ""
a.save

a = AlternativaQuestao.create(id: 7, questao_avaliacao_id: 2, is_correta: true )
a.label_alternativa.body = "Porque não existe um algoritmo geral capaz de determinar, em tempo finito, se qualquer proposição lógica é verdadeira ou falsa"
a.explicacao_alternativa.body = ""
a.save

a = AlternativaQuestao.create(id: 8, questao_avaliacao_id: 2, is_correta: false )
a.label_alternativa.body = "Porque sua solução depende exclusivamente da velocidade de processamento disponível no computador"
a.explicacao_alternativa.body = ""
a.save

a = AlternativaQuestao.create(id: 9, questao_avaliacao_id: 2, is_correta: false )
a.label_alternativa.body = "Porque só pode ser resolvido para proposições escritas em linguagens naturais, e não em linguagens formais"
a.explicacao_alternativa.body = ""
a.save

a = AlternativaQuestao.create(id: 10, questao_avaliacao_id: 2, is_correta: false )
a.label_alternativa.body = "Porque foi demonstrado que apenas computadores quânticos podem resolver esse tipo de problema"
a.explicacao_alternativa.body = ""
a.save

a = AlternativaQuestao.create(id: 11, questao_avaliacao_id: 3, is_correta: false )
a.label_alternativa.body = "NP-Completo"
a.explicacao_alternativa.body = ""
a.save

a = AlternativaQuestao.create(id: 12, questao_avaliacao_id: 3, is_correta: false )
a.label_alternativa.body = "P"
a.explicacao_alternativa.body = ""
a.save

a = AlternativaQuestao.create(id: 13, questao_avaliacao_id: 3, is_correta: false )
a.label_alternativa.body = "NP-Fácil"
a.explicacao_alternativa.body = ""
a.save

a = AlternativaQuestao.create(id: 14, questao_avaliacao_id: 3, is_correta: false )
a.label_alternativa.body = "NP-Equivalente"
a.explicacao_alternativa.body = ""
a.save

a = AlternativaQuestao.create(id: 15, questao_avaliacao_id: 3, is_correta: true )
a.label_alternativa.body = "NP-Difícil"
a.explicacao_alternativa.body = ""
a.save

a = AlternativaQuestao.create(id: 16, questao_avaliacao_id: 4, is_correta: false )
a.label_alternativa.body = "A parábola do quarto chinês reforça a ideia de Turing de que a compreensão da linguagem é suficiente para demonstrar inteligência genuína"
a.explicacao_alternativa.body = ""
a.save

a = AlternativaQuestao.create(id: 17, questao_avaliacao_id: 4, is_correta: false )
a.label_alternativa.body = "A parábola do quarto chinês propõe um método alternativo ao jogo da imitação para medir a velocidade de processamento dos computadores"
a.explicacao_alternativa.body = ""
a.save

a = AlternativaQuestao.create(id: 18, questao_avaliacao_id: 4, is_correta: true )
a.label_alternativa.body = "A parábola do quarto chinês critica a conclusão de que um sistema que passa no jogo da imitação necessariamente compreende o significado do que comunica"
a.explicacao_alternativa.body = ""
a.save

a = AlternativaQuestao.create(id: 19, questao_avaliacao_id: 4, is_correta: false )
a.label_alternativa.body = "A parábola do quarto chinês demonstra que apenas seres humanos são capazes de participar do jogo da imitação"
a.explicacao_alternativa.body = ""
a.save

a = AlternativaQuestao.create(id: 20, questao_avaliacao_id: 4, is_correta: false )
a.label_alternativa.body = "A parábola do quarto chinês e o jogo da imitação defendem que a inteligência depende exclusivamente da capacidade de realizar cálculos matemáticos complexos"
a.explicacao_alternativa.body = ""
a.save

a = AlternativaQuestao.create(id: 21, questao_avaliacao_id: 5, is_correta: false )
a.label_alternativa.body = "O teorema de Gödel demonstra que uma Máquina Universal de Turing é logicamente impossível de ser construída"
a.explicacao_alternativa.body = ""
a.save

a = AlternativaQuestao.create(id: 22, questao_avaliacao_id: 5, is_correta: false )
a.label_alternativa.body = "O teorema de Gödel prova que uma Máquina Universal de Turing pode resolver qualquer problema matemático existente"
a.explicacao_alternativa.body = ""
a.save

a = AlternativaQuestao.create(id: 23, questao_avaliacao_id: 5, is_correta: true )
a.label_alternativa.body = "O teorema de Gödel mostra que existem verdades matemáticas que não podem ser demonstradas em certos sistemas formais, enquanto a Máquina Universal de Turing evidencia os limites do que pode ser computado, revelando restrições fundamentais ao raciocínio mecânico"
a.explicacao_alternativa.body = ""
a.save

a = AlternativaQuestao.create(id: 24, questao_avaliacao_id: 5, is_correta: false )
a.label_alternativa.body = "O teorema de Gödel estabelece que toda computação realizada por uma Máquina Universal de Turing é necessariamente incompleta e incorreta"
a.explicacao_alternativa.body = ""
a.save

a = AlternativaQuestao.create(id: 25, questao_avaliacao_id: 5, is_correta: false )
a.label_alternativa.body = "O teorema de Gödel e a Máquina Universal de Turing demonstram que qualquer problema matemático pode ser resolvido por meio de algoritmos suficientemente complexos"
a.explicacao_alternativa.body = ""
a.save

a = AlternativaQuestao.create(id: 26, questao_avaliacao_id: 6, is_correta: true )
a.label_alternativa.body = "Máquina de Moore"
a.explicacao_alternativa.body = ""
a.save

a = AlternativaQuestao.create(id: 27, questao_avaliacao_id: 6, is_correta: false )
a.label_alternativa.body = "Máquina de Kleene"
a.explicacao_alternativa.body = ""
a.save

a = AlternativaQuestao.create(id: 28, questao_avaliacao_id: 6, is_correta: false )
a.label_alternativa.body = "Máquina de Turing"
a.explicacao_alternativa.body = ""
a.save

a = AlternativaQuestao.create(id: 29, questao_avaliacao_id: 6, is_correta: true )
a.label_alternativa.body = "Máquina de Mealy"
a.explicacao_alternativa.body = ""
a.save

a = AlternativaQuestao.create(id: 30, questao_avaliacao_id: 6, is_correta: false )
a.label_alternativa.body = "Máquina de Church"
a.explicacao_alternativa.body = ""
a.save

a = AlternativaQuestao.create(id: 31, questao_avaliacao_id: 7, is_correta: false )
a.label_alternativa.body = "Linguagem recursivamente enumerada"
a.explicacao_alternativa.body = ""
a.save

a = AlternativaQuestao.create(id: 32, questao_avaliacao_id: 7, is_correta: true )
a.label_alternativa.body = "Linguagem livre de contexto"
a.explicacao_alternativa.body = ""
a.save

a = AlternativaQuestao.create(id: 33, questao_avaliacao_id: 7, is_correta: false )
a.label_alternativa.body = "Linguagem sensível ao contexto"
a.explicacao_alternativa.body = ""
a.save

a = AlternativaQuestao.create(id: 34, questao_avaliacao_id: 7, is_correta: false )
a.label_alternativa.body = "Linguagem regular"
a.explicacao_alternativa.body = ""
a.save

a = AlternativaQuestao.create(id: 35, questao_avaliacao_id: 7, is_correta: false )
a.label_alternativa.body = "Liguagem irregular"
a.explicacao_alternativa.body = ""
a.save

a = AlternativaQuestao.create(id: 36, questao_avaliacao_id: 8, is_correta: false )
a.label_alternativa.body = "Sim, pois toda equação diofantina pode ser resolvida por meio de um procedimento computacional geral"
a.explicacao_alternativa.body = ""
a.save

a = AlternativaQuestao.create(id: 37, questao_avaliacao_id: 8, is_correta: true )
a.label_alternativa.body = "Não, pois foi demonstrado que não existe um algoritmo geral capaz de decidir, para toda equação diofantina, se ela possui ou não solução inteira"
a.explicacao_alternativa.body = ""
a.save

a = AlternativaQuestao.create(id: 38, questao_avaliacao_id: 8, is_correta: false )
a.label_alternativa.body = "Sim, desde que a equação possua apenas duas incógnitas"
a.explicacao_alternativa.body = ""
a.save

a = AlternativaQuestao.create(id: 39, questao_avaliacao_id: 8, is_correta: false )
a.label_alternativa.body = "Não, porque computadores não conseguem realizar cálculos com números inteiros muito grandes"
a.explicacao_alternativa.body = ""
a.save

a = AlternativaQuestao.create(id: 40, questao_avaliacao_id: 8, is_correta: false )
a.label_alternativa.body = "Sim, pois o Teorema da Incompletude de Gödel fornece um método para determinar a existência de soluções."
a.explicacao_alternativa.body = ""
a.save

a = AlternativaQuestao.create(id: 41, questao_avaliacao_id: 9, is_correta: false )
a.label_alternativa.body = "Cálculo Theta"
a.explicacao_alternativa.body = ""
a.save

a = AlternativaQuestao.create(id: 42, questao_avaliacao_id: 9, is_correta: false )
a.label_alternativa.body = "Cálculo Gamma"
a.explicacao_alternativa.body = ""
a.save

a = AlternativaQuestao.create(id: 43, questao_avaliacao_id: 9, is_correta: false )
a.label_alternativa.body = "Cálculo Sigma"
a.explicacao_alternativa.body = ""
a.save

a = AlternativaQuestao.create(id: 44, questao_avaliacao_id: 9, is_correta: false )
a.label_alternativa.body = "Cálculo Ômega"
a.explicacao_alternativa.body = ""
a.save

a = AlternativaQuestao.create(id: 45, questao_avaliacao_id: 9, is_correta: true )
a.label_alternativa.body = "Cálculo Lambda"
a.explicacao_alternativa.body = ""
a.save

a = AlternativaQuestao.create(id: 46, questao_avaliacao_id: 10, is_correta: false )
a.label_alternativa.body = "1940"
a.explicacao_alternativa.body = ""
a.save

a = AlternativaQuestao.create(id: 47, questao_avaliacao_id: 10, is_correta: true )
a.label_alternativa.body = "1936"
a.explicacao_alternativa.body = ""
a.save

a = AlternativaQuestao.create(id: 48, questao_avaliacao_id: 10, is_correta: false )
a.label_alternativa.body = "1935"
a.explicacao_alternativa.body = ""
a.save

a = AlternativaQuestao.create(id: 49, questao_avaliacao_id: 10, is_correta: false )
a.label_alternativa.body = "1937"
a.explicacao_alternativa.body = ""
a.save

a = AlternativaQuestao.create(id: 50, questao_avaliacao_id: 10, is_correta: false )
a.label_alternativa.body = "1939"
a.explicacao_alternativa.body = ""
a.save

puts "= alternativa questoes populada."

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

