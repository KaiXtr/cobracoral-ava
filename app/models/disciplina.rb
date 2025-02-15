class Disciplina < ApplicationRecord
    belongs_to :curso
    has_many :unidade_disciplinas
end
