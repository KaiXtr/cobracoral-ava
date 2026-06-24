class Avaliacao < ApplicationRecord
  self.table_name = "avaliacoes"

  belongs_to :unidade_disciplina
  has_many :questao_avaliacao
  has_many :tentativa_avaliacao

  has_rich_text :corpo
  
  def to_partial_path 
    'avaliacoes/avaliacao' 
  end

  def to_show_path 
    'avaliacoes/show' 
  end

  def to_edit_path 
    'avaliacoes/edit' 
  end
end
