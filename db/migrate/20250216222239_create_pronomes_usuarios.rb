class CreatePronomesUsuarios < ActiveRecord::Migration[7.0]
  def change
    create_table :pronomes_usuarios do |t|
      t.string :enumPronomes

      t.timestamps
    end
  end
end
