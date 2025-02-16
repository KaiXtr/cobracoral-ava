class Disciplina < ApplicationRecord
    belongs_to :curso
    belongs_to :turma
    belongs_to :usuario
    has_many :unidade_disciplinas
end
