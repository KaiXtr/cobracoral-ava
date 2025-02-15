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

ActiveRecord::Schema[7.0].define(version: 2025_02_15_220722) do
  create_table "conteudos", force: :cascade do |t|
    t.integer "unidade_disciplina_id", null: false
    t.string "nome_conteudo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["unidade_disciplina_id"], name: "index_conteudos_on_unidade_disciplina_id"
  end

  create_table "cursos", force: :cascade do |t|
    t.string "nome_curso"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "descricao"
  end

  create_table "disciplinas", force: :cascade do |t|
    t.string "nome_disciplina"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "cursos_id", null: false
    t.string "semestre"
    t.index ["cursos_id"], name: "index_disciplinas_on_cursos_id"
  end

  create_table "turmas", force: :cascade do |t|
    t.string "nome_turma"
    t.string "senha_acesso"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
  add_foreign_key "disciplinas", "cursos", column: "cursos_id"
  add_foreign_key "unidade_disciplinas", "disciplinas"
end
