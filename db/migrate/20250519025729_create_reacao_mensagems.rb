class CreateReacaoMensagems < ActiveRecord::Migration[7.2]
  def change
    create_table :reacao_mensagens do |t|
      t.references :mensagem, null: false, foreign_key: { to_table: :mensagens }
      t.references :usuario, null: false, foreign_key: true
      t.string :emoji

      t.timestamps
    end
  end
end
