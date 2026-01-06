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

ActiveRecord::Schema[8.1].define(version: 2026_01_06_021114) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "labels", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "mix_tracks", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "mix_id", null: false
    t.integer "position", null: false
    t.integer "start_seconds", null: false
    t.bigint "track_id", null: false
    t.datetime "updated_at", null: false
    t.index ["mix_id", "track_id"], name: "index_mix_tracks_on_mix_id_and_track_id", unique: true
    t.index ["mix_id"], name: "index_mix_tracks_on_mix_id"
    t.index ["track_id"], name: "index_mix_tracks_on_track_id"
  end

  create_table "mixes", force: :cascade do |t|
    t.string "audio_url"
    t.datetime "created_at", null: false
    t.string "dj_name"
    t.integer "duration_seconds"
    t.datetime "recorded_at"
    t.integer "status"
    t.string "title"
    t.datetime "updated_at", null: false
  end

  create_table "tracks", force: :cascade do |t|
    t.string "artist"
    t.integer "bpm"
    t.datetime "created_at", null: false
    t.integer "duration_seconds"
    t.string "isrc"
    t.bigint "label_id", null: false
    t.boolean "pool_eligible"
    t.string "title"
    t.datetime "updated_at", null: false
    t.index ["label_id"], name: "index_tracks_on_label_id"
  end

  add_foreign_key "mix_tracks", "mixes"
  add_foreign_key "mix_tracks", "tracks"
  add_foreign_key "tracks", "labels"
end
