class CreateAlternativaQuestoes < ActiveRecord::Migration[7.2]
  def change
    create_table :alternativa_questoes do |t|
      t.references :questao_avaliacao, null: false, foreign_key: { to_table: :questao_avaliacoes }
      t.boolean :is_correta

      t.timestamps
    end
  end
end
