class CreateAssuntoSolicitacoes < ActiveRecord::Migration[7.2]
  def change
    create_table :assunto_solicitacoes do |t|
      t.string :enum_assunto 

      t.timestamps
    end
  end
end
