# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2025_04_21_203759) do
  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.integer "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "comunicados", force: :cascade do |t|
    t.integer "usuario_id", null: false
    t.integer "turma_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "visibilidade_comunicado", null: false
    t.index ["turma_id"], name: "index_comunicados_on_turma_id"
    t.index ["usuario_id"], name: "index_comunicados_on_usuario_id"
  end

  create_table "conteudos", force: :cascade do |t|
    t.integer "unidade_disciplina_id", null: false
    t.string "nome_conteudo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "data_liberacao"
    t.datetime "data_vencimento"
    t.index ["unidade_disciplina_id"], name: "index_conteudos_on_unidade_disciplina_id"
  end

  create_table "cursos", force: :cascade do |t|
    t.string "nome_curso"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "descricao"
    t.integer "usuario_id", null: false
    t.index ["usuario_id"], name: "index_cursos_on_usuario_id"
  end

  create_table "disciplinas", force: :cascade do |t|
    t.string "nome_disciplina"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "curso_id", null: false
    t.string "semestre"
    t.string "sala_aula"
    t.integer "turma_id", null: false
    t.integer "usuario_id", null: false
    t.index ["curso_id"], name: "index_disciplinas_on_curso_id"
    t.index ["turma_id"], name: "index_disciplinas_on_turma_id"
    t.index ["usuario_id"], name: "index_disciplinas_on_usuario_id"
  end

  create_table "leitura_conteudos", force: :cascade do |t|
    t.integer "conteudo_id", null: false
    t.integer "usuario_id", null: false
    t.integer "conclusao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["conteudo_id"], name: "index_leitura_conteudos_on_conteudo_id"
    t.index ["usuario_id"], name: "index_leitura_conteudos_on_usuario_id"
  end

  create_table "matriculas", force: :cascade do |t|
    t.integer "turma_id", null: false
    t.integer "usuario_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "semestre"
    t.index ["turma_id"], name: "index_matriculas_on_turma_id"
    t.index ["usuario_id"], name: "index_matriculas_on_usuario_id"
  end

  create_table "preferencia_usuarios", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "idioma"
    t.string "tema"
    t.boolean "avaliacao_exibir_tempo"
    t.boolean "avaliacao_exibir_progresso"
    t.boolean "pomodoro_ativar"
    t.integer "pomodoro_pomodoris_tempo"
    t.integer "pomodoro_descanso"
    t.boolean "pomodoro_hibernar"
    t.boolean "pomodoro_logoff"
    t.boolean "notificacao_novo_acesso"
    t.boolean "notificacao_comunicados_coordenacao"
    t.boolean "notificacao_comunicados_turma"
    t.boolean "notificacao_agendamentos"
    t.boolean "notificacao_avaliacao_liberada"
    t.boolean "notificacao_conteudo_liberado"
    t.boolean "notificacao_nota_lancada"
    t.boolean "notificacao_nova_mensagem"
    t.boolean "notificacao_situacao_solicitacao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_preferencia_usuarios_on_user_id"
  end

  create_table "reacao_comunicados", force: :cascade do |t|
    t.integer "comunicado_id", null: false
    t.integer "usuario_id", null: false
    t.string "emoji"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["comunicado_id"], name: "index_reacao_comunicados_on_comunicado_id"
    t.index ["usuario_id"], name: "index_reacao_comunicados_on_usuario_id"
  end

  create_table "turmas", force: :cascade do |t|
    t.string "nome_turma"
    t.string "senha_acesso"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "curso_id", null: false
    t.integer "turno_turma", null: false
    t.integer "modalidade_turma", null: false
    t.index ["curso_id"], name: "index_turmas_on_curso_id"
  end

  create_table "unidade_disciplinas", force: :cascade do |t|
    t.integer "disciplina_id", null: false
    t.string "nome_unidade"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["disciplina_id"], name: "index_unidade_disciplinas_on_disciplina_id"
  end

  create_table "usuarios", force: :cascade do |t|
    t.string "nome_completo"
    t.string "email"
    t.integer "telefone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "pronomes_usuario", null: false
    t.string "biografia"
    t.string "lattes_id"
    t.string "orcid_id"
    t.string "password_digest"
    t.integer "cargo_usuario", null: false
    t.integer "acessos_count"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "comunicados", "turmas"
  add_foreign_key "comunicados", "usuarios"
  add_foreign_key "conteudos", "unidade_disciplinas"
  add_foreign_key "cursos", "usuarios"
  add_foreign_key "disciplinas", "cursos"
  add_foreign_key "disciplinas", "turmas"
  add_foreign_key "disciplinas", "usuarios"
  add_foreign_key "leitura_conteudos", "conteudos"
  add_foreign_key "leitura_conteudos", "usuarios"
  add_foreign_key "matriculas", "turmas"
  add_foreign_key "matriculas", "usuarios"
  add_foreign_key "preferencia_usuarios", "users"
  add_foreign_key "reacao_comunicados", "comunicados"
  add_foreign_key "reacao_comunicados", "usuarios"
  add_foreign_key "turmas", "cursos"
  add_foreign_key "unidade_disciplinas", "disciplinas"
end
