class Comunicado < ApplicationRecord
  belongs_to :usuario
  belongs_to :turma

  has_many_attached :imagens
  has_rich_text :corpo

  validates_presence_of :usuario
  validates_presence_of :turma
end
