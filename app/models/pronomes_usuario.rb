class PronomesUsuario < ApplicationRecord
	validates_presence_of :enumPronomes
	validates_uniqueness_of :enumPronomes
end
