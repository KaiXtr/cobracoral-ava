  class CreatePreferenciaUsuario < ActiveRecord::Migration[7.2]
  def change
    create_table :preferencia_usuario do |t|
      t.references :user, null: false, foreign_key: true
      t.string :idioma, default: "pt-BR"
      t.string :tema, default: "default"
      t.boolean :avaliacao_exibir_tempo, default: true
      t.boolean :avaliacao_exibir_progresso, default: true
      t.boolean :pomodoro_ativar, default: true
      t.integer :pomodoro_pomodoris_tempo, default: 25
      t.integer :pomodoro_descanso, default: 5
      t.integer :pomodoro_pomodoris_quant, default: 4
      t.boolean :pomodoro_hibernar, default: true
      t.boolean :pomodoro_logoff, default: false
      t.boolean :notificacao_novo_acesso, default: true
      t.boolean :notificacao_comunicados_coordenacao, default: true
      t.boolean :notificacao_comunicados_turma, default: true
      t.boolean :notificacao_agendamentos, default: true
      t.boolean :notificacao_avaliacao_liberada, default: true
      t.boolean :notificacao_conteudo_liberado, default: true
      t.boolean :notificacao_nota_lancada, default: true
      t.boolean :notificacao_nova_mensagem, default: true
      t.boolean :notificacao_situacao_solicitacao, default: true

      t.timestamps
    end
  end
end
