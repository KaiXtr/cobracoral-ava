class MatrizCurricular < ApplicationRecord
    belongs_to :curso
    has_many :ementa
end
