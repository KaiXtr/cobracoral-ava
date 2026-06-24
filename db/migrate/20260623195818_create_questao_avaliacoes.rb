class CreateQuestaoAvaliacoes < ActiveRecord::Migration[7.2]
  def change
    create_table :questao_avaliacoes do |t|
      t.references :avaliacao, null: false, foreign_key: { to_table: :avaliacoes }
      t.integer :peso_questao

      t.timestamps
    end
  end
end
