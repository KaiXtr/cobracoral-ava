class AddDatasAndUrlToConteudo < ActiveRecord::Migration[7.0]
  def change
    add_column :conteudos, :url_conteudo, :string
    add_column :conteudos, :data_liberacao, :datetime
    add_column :conteudos, :data_vencimento, :datetime
  end
end
