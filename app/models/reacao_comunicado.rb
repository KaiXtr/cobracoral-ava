class ReacaoComunicado < ApplicationRecord
  belongs_to :comunicado
  belongs_to :usuario

  validates_presence_of :comunicado
  validates_presence_of :usuario
end
