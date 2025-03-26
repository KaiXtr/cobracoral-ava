class Comunicado < ApplicationRecord
  belongs_to :turma
  belongs_to :usuario

  has_many :reacao_comunicado
  has_many_attached :imagens
  has_rich_text :corpo

  validates_presence_of :usuario
  validates_presence_of :turma

  enum :visibilidade_comunicado, [
    :todos_curso,
    :todas_turmas,
    :todos_turma,
    :todos_disciplina
  ]

  def self.visibilidade_comunicado_strings
    return {
      todos_curso_string: 'Todos do curso',
      todas_turmas_string: 'Todas as turmas',
      todos_turma_string: 'Todos da turma',
      todos_disciplina_string: 'Todos da disciplina'
    }
  end
end
