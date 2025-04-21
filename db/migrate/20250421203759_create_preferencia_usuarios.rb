  class CreatePreferenciaUsuarios < ActiveRecord::Migration[7.2]
  def change
    create_table :preferencia_usuarios do |t|
      t.references :user, null: false, foreign_key: true
      t.string :idioma
      t.string :tema
      t.boolean :avaliacao_exibir_tempo
      t.boolean :avaliacao_exibir_progresso
      t.boolean :pomodoro_ativar
      t.integer :pomodoro_pomodoris_tempo
      t.integer :pomodoro_descanso
      t.boolean :pomodoro_hibernar
      t.boolean :pomodoro_logoff
      t.boolean :notificacao_novo_acesso
      t.boolean :notificacao_comunicados_coordenacao
      t.boolean :notificacao_comunicados_turma
      t.boolean :notificacao_agendamentos
      t.boolean :notificacao_avaliacao_liberada
      t.boolean :notificacao_conteudo_liberado
      t.boolean :notificacao_nota_lancada
      t.boolean :notificacao_nova_mensagem
      t.boolean :notificacao_situacao_solicitacao

      t.timestamps
    end
  end
end
