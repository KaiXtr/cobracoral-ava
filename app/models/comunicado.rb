class Comunicado < ApplicationRecord
  belongs_to :turma
  belongs_to :usuario
  belongs_to :visibilidade_comunicado

  has_many :reacao_comunicado
  has_many_attached :imagens
  has_rich_text :corpo

  validates_presence_of :usuario
  validates_presence_of :turma
end
