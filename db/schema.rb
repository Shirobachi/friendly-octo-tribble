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

ActiveRecord::Schema[7.0].define(version: 2022_05_02_065059) do
  create_table "answers", force: :cascade do |t|
    t.integer "game_id", null: false
    t.integer "question_id", null: false
    t.integer "team_id", null: false
    t.string "answer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_answers_on_game_id"
    t.index ["question_id"], name: "index_answers_on_question_id"
    t.index ["team_id"], name: "index_answers_on_team_id"
  end

  create_table "game_progresses", force: :cascade do |t|
    t.integer "game_id", null: false
    t.integer "question_id", null: false
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_game_progresses_on_game_id"
    t.index ["question_id"], name: "index_game_progresses_on_question_id"
  end

  create_table "game_questions", force: :cascade do |t|
    t.integer "game_id", null: false
    t.integer "question_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_game_questions_on_game_id"
    t.index ["question_id"], name: "index_game_questions_on_question_id"
  end

  create_table "game_teams", force: :cascade do |t|
    t.integer "game_id", null: false
    t.integer "team_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_game_teams_on_game_id"
    t.index ["team_id"], name: "index_game_teams_on_team_id"
  end

  create_table "games", force: :cascade do |t|
    t.string "name"
    t.string "status", default: "configuring"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "questions", force: :cascade do |t|
    t.string "question", null: false
    t.string "ansA", null: false
    t.string "ansB", null: false
    t.string "ansC", null: false
    t.string "ansD", null: false
    t.integer "points", default: 1
    t.integer "time", default: 120
    t.string "justificationUrl"
    t.string "justification"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "used", default: 0
    t.boolean "active", default: true
  end

  create_table "rules", force: :cascade do |t|
    t.string "content"
    t.integer "orderID"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.integer "bestScore", default: -1
    t.string "linkToPhoto"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "webhooks", force: :cascade do |t|
    t.integer "game_progress_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "lang"
    t.index ["game_progress_id"], name: "index_webhooks_on_game_progress_id"
  end

  add_foreign_key "answers", "games"
  add_foreign_key "answers", "questions"
  add_foreign_key "answers", "teams"
  add_foreign_key "game_progresses", "games"
  add_foreign_key "game_progresses", "questions"
  add_foreign_key "game_questions", "games"
  add_foreign_key "game_questions", "questions"
  add_foreign_key "game_teams", "games"
  add_foreign_key "game_teams", "teams"
  add_foreign_key "webhooks", "game_progresses"
end
