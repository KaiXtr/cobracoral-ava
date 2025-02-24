json.extract! comunicado, :id, :usuario_id, :turma_id, :conteudo, :url_img, :created_at, :updated_at
json.url comunicado_url(comunicado, format: :json)
