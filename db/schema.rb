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

ActiveRecord::Schema[7.0].define(version: 2025_02_16_002817) do
  create_table "conteudos", force: :cascade do |t|
    t.integer "unidade_disciplina_id", null: false
    t.string "nome_conteudo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["unidade_disciplina_id"], name: "index_conteudos_on_unidade_disciplina_id"
  end

  create_table "cursos", force: :cascade do |t|
    t.string "nome_curso"
    t.string "descricao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "disciplinas", force: :cascade do |t|
    t.string "nome_disciplina"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "curso_id", null: false
    t.string "semestre"
    t.index ["curso_id"], name: "index_disciplinas_on_curso_id"
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

  create_table "turmas", force: :cascade do |t|
    t.string "nome_turma"
    t.string "senha_acesso"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "curso_id", null: false
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
    t.string "senha"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "conteudos", "unidade_disciplinas"
  add_foreign_key "disciplinas", "cursos"
  add_foreign_key "leitura_conteudos", "conteudos"
  add_foreign_key "leitura_conteudos", "usuarios"
  add_foreign_key "turmas", "cursos"
  add_foreign_key "unidade_disciplinas", "disciplinas"
end
