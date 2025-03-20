class Turma < ApplicationRecord
    belongs_to :curso
    belongs_to :turno_turma
    belongs_to :modalidade_turma

    has_many :matricula
    has_many :disciplina
    has_many :comunicado
end
