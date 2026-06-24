class CreateRespostaTentativas < ActiveRecord::Migration[7.2]
  def change
    create_table :resposta_tentativas do |t|
      t.references :tentativa_avaliacao, null: false, foreign_key: { to_table: :tentativa_avaliacoes }
      t.references :questao_avaliacao, null: false, foreign_key: { to_table: :questao_avaliacoes }
      t.references :alternativa_questao, null: false, foreign_key: { to_table: :alternativa_questoes }

      t.timestamps
    end
  end
end
