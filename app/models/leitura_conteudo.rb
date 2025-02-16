class LeituraConteudo < ApplicationRecord
  after_initialize :set_defaults, unless: :persisted?
  belongs_to :conteudo
  belongs_to :usuario

  def set_defaults
    self.conclusao = 0
  end
end
