class AddPasswordDigestToUsuario < ActiveRecord::Migration[7.0]
  def change
    add_column :usuarios, :password_digest, :string
    remove_column :usuarios, :senha, :string
  end
end
