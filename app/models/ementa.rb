class Ementa < ApplicationRecord
    self.table_name = "ementas"

    belongs_to :matriz_curricular
    belongs_to :semestre
    has_many :disciplina

    has_rich_text :anexo
end
