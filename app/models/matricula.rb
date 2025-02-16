class Matricula < ApplicationRecord
  belongs_to :turma
  belongs_to :usuario
  has_many :matricula_cargo
end
