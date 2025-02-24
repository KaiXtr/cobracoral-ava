class CreateReacaoComunicados < ActiveRecord::Migration[7.0]
  def change
    create_table :reacao_comunicados do |t|
      t.references :comunicado, null: false, foreign_key: true
      t.references :usuario, null: false, foreign_key: true
      t.string :emoji

      t.timestamps
    end
  end
end
