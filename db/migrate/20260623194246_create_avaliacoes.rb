class CreateAvaliacoes < ActiveRecord::Migration[7.2]
  def change
    create_table :avaliacoes do |t|
      t.references :unidade_disciplina, null: false, foreign_key: true
      t.string :nome_avaliacao
      t.integer :nota_total
      t.datetime :data_liberacao
      t.datetime :data_vencimento
      t.integer :tempo_limite, null: true
      t.integer :quant_questoes
      t.integer :quant_tentativas
      t.boolean :is_recuperacao

      t.timestamps
    end
  end
end
