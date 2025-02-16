class Turma < ApplicationRecord
    belongs_to :curso
    has_many :matricula
    has_many :turno_turma
    has_many :modalidade_turma
end
