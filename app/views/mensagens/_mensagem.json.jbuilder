json.extract! mensagem, :id, :remetente_id, :destinatario_id, :created_at, :updated_at
json.url mensagem_url(mensagem, format: :json)
