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

ActiveRecord::Schema.define(version: 2021_04_05_101611) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "matter_types", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.boolean "upper_gross_income_waiver", default: false, null: false
    t.boolean "upper_disposable_income_waiver", default: false, null: false
    t.boolean "upper_capital_waiver", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_matter_types_on_name", unique: true
  end

  create_table "merits_tasks", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "type", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "proceeding_type_merits_tasks", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "proceeding_type_id", null: false
    t.uuid "merits_task_id", null: false
    t.integer "sequence", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["proceeding_type_id"], name: "index_proceeding_type_merits_tasks_on_proceeding_type_id"
  end

  create_table "proceeding_types", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "ccms_code", null: false
    t.string "meaning", null: false
    t.string "description", null: false
    t.uuid "matter_type_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "request_histories", force: :cascade do |t|
    t.string "request_method"
    t.string "request_id"
    t.string "endpoint"
    t.inet "remote_ip"
    t.string "request_payload"
    t.integer "response_status"
    t.string "response_payload"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "task_dependencies", force: :cascade do |t|
    t.uuid "merits_task_id"
    t.uuid "dependency_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
