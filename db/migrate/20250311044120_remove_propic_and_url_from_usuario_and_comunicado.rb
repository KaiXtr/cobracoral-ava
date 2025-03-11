class RemovePropicAndUrlFromUsuarioAndComunicado < ActiveRecord::Migration[7.0]
  def change
    remove_column :usuarios, :profile_pic, :string
    remove_column :comunicados, :conteudo, :string
    remove_column :comunicados, :url_img, :string
    remove_column :conteudos, :url_conteudo, :string
  end
end
