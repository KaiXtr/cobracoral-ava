class PronomesUsuario < ApplicationRecord
	has_many :usuario
	validates_presence_of :enumPronomes
	validates_uniqueness_of :enumPronomes
end
