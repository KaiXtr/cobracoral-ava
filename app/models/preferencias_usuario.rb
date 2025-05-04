class PreferenciasUsuario < ApplicationRecord
  belongs_to :usuario

  self.table_name = "preferencias_usuario"

  enum tema: { default: 'default', escuro: 'escuro', claro: 'claro' }

  validates :idioma, format: { with: /\A[a-z]{2}-[A-Z]{2}\z/, message: "deve estar no formato ISO (ex: pt-BR)" }
end