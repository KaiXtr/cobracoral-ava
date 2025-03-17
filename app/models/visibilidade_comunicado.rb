class VisibilidadeComunicado < ApplicationRecord
    has_many :comunicado
    validates_presence_of :comunicado
end
