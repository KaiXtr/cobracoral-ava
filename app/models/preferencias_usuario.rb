class PreferenciasUsuario < ApplicationRecord
  belongs_to :user

  enum tema: { default: 'default', escuro: 'escuro', claro: 'claro' } # ajuste conforme necessário

  validates :idioma, format: { with: /\A[a-z]{2}-[A-Z]{2}\z/, message: "deve estar no formato ISO (ex: pt-BR)" }
end