class CreateTentativaAvaliacoes < ActiveRecord::Migration[7.2]
  def change
    create_table :tentativa_avaliacoes do |t|
      t.references :usuario, null: false, foreign_key: true
      t.references :avaliacao, null: false, foreign_key: { to_table: :avaliacoes }
      t.integer :nota

      t.timestamps
    end
  end
end
