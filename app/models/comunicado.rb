class Comunicado < ApplicationRecord
  belongs_to :usuario
  belongs_to :turma

  validates_presence_of :usuario
  validates_presence_of :turma
end
