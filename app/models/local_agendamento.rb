class LocalAgendamento < ApplicationRecord
    has_many :agendamento
    
	validates_presence_of :edificio
	validates_presence_of :local
	validates_uniqueness_of :local
end
