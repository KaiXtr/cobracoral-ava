class AddColumnsToUsuario < ActiveRecord::Migration[7.0]
  def change
    add_reference :usuarios, :pronomes_usuario, null: false, foreign_key: true
    add_column :usuarios, :profile_pic, :string
    add_column :usuarios, :biografia, :string
    add_column :usuarios, :lattes_id, :string
    add_column :usuarios, :orcid_id, :string
  end
end
