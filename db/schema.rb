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

ActiveRecord::Schema[7.0].define(version: 2022_08_10_143751) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "client_involvement_types", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "ccms_code", null: false
    t.string "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "ordering"
  end

  create_table "default_cost_limitations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "proceeding_type_id", null: false
    t.date "start_date", null: false
    t.string "cost_type", null: false
    t.decimal "value", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["proceeding_type_id", "cost_type", "start_date"], name: "index_default_cost_limitations_unique_on_cost_date_and_type", unique: true
    t.index ["proceeding_type_id"], name: "index_default_cost_limitations_on_proceeding_type_id"
  end

  create_table "matter_types", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "category_of_law"
    t.string "code"
    t.string "category_of_law_code"
    t.index ["name"], name: "index_matter_types_on_name", unique: true
  end

  create_table "merits_tasks", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "proceeding_type_merits_tasks", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "proceeding_type_id", null: false
    t.uuid "merits_task_id", null: false
    t.integer "sequence", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["proceeding_type_id"], name: "index_proceeding_type_merits_tasks_on_proceeding_type_id"
  end

  create_table "proceeding_type_scope_limitations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "proceeding_type_id"
    t.uuid "scope_limitation_id"
    t.boolean "substantive_default"
    t.boolean "delegated_functions_default"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["proceeding_type_id", "delegated_functions_default"], name: "index_proceedings_scopes_unique_delegated_default", unique: true, where: "(delegated_functions_default = true)"
    t.index ["proceeding_type_id", "scope_limitation_id"], name: "index_proceedings_scopes_unique_on_ids", unique: true
    t.index ["proceeding_type_id", "substantive_default"], name: "index_proceedings_scopes_unique_substantive_default", unique: true, where: "(substantive_default = true)"
    t.index ["proceeding_type_id"], name: "index_proceeding_type_scope_limitations_on_proceeding_type_id"
    t.index ["scope_limitation_id"], name: "index_proceeding_type_scope_limitations_on_scope_limitation_id"
  end

  create_table "proceeding_type_service_levels", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "proceeding_type_id"
    t.uuid "service_level_id"
    t.boolean "proceeding_default"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["proceeding_type_id", "proceeding_default"], name: "index_proceedings_service_levels_unique_default", unique: true, where: "(proceeding_default = true)"
    t.index ["proceeding_type_id", "service_level_id"], name: "index_proceedings_service_levels_unique_on_ids", unique: true
    t.index ["proceeding_type_id"], name: "index_proceeding_type_service_levels_on_proceeding_type_id"
    t.index ["service_level_id"], name: "index_proceeding_type_service_levels_on_service_level_id"
  end

  create_table "proceeding_types", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "ccms_code", null: false
    t.string "meaning", null: false
    t.string "description", null: false
    t.uuid "matter_type_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "additional_search_terms"
    t.tsvector "textsearchable"
    t.string "name", default: "default_name", null: false
    t.boolean "full_s8_only", default: false, null: false
    t.index ["textsearchable"], name: "textsearch_idx", using: :gin
  end

  create_table "request_histories", force: :cascade do |t|
    t.string "request_method"
    t.string "request_id"
    t.string "endpoint"
    t.inet "remote_ip"
    t.string "request_payload"
    t.integer "response_status"
    t.string "response_payload"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "scope_limitation_user_inputs", force: :cascade do |t|
    t.uuid "scope_limitation_id"
    t.uuid "scope_user_input_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["scope_limitation_id"], name: "index_scope_limitation_user_inputs_on_scope_limitation_id"
    t.index ["scope_user_input_id"], name: "index_scope_limitation_user_inputs_on_scope_user_input_id"
  end

  create_table "scope_limitations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "code", null: false
    t.string "meaning", null: false
    t.string "description", null: false
    t.boolean "substantive", default: false, null: false
    t.boolean "delegated_functions", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_scope_limitations_on_code"
  end

  create_table "scope_user_inputs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "input_name", null: false
    t.text "input_type", null: false
    t.boolean "mandatory", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["input_name"], name: "index_scope_user_inputs_on_input_name", unique: true
  end

  create_table "service_levels", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "level", null: false
    t.string "name", null: false
    t.integer "stage"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["level"], name: "index_service_levels_unique_on_level", unique: true
  end

  create_table "task_dependencies", force: :cascade do |t|
    t.uuid "merits_task_id"
    t.uuid "dependency_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "threshold_waivers", force: :cascade do |t|
    t.uuid "client_involvement_type_id", null: false
    t.uuid "matter_type_id", null: false
    t.boolean "gross_income_upper"
    t.boolean "disposable_income_upper"
    t.boolean "capital_upper"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_involvement_type_id", "matter_type_id"], name: "index_threshold_waivers_on_client_involvement_and_matter_types", unique: true
    t.index ["client_involvement_type_id"], name: "index_threshold_waivers_on_client_involvement_type_id"
    t.index ["matter_type_id"], name: "index_threshold_waivers_on_matter_type_id"
  end

  add_foreign_key "default_cost_limitations", "proceeding_types"
  add_foreign_key "proceeding_type_scope_limitations", "proceeding_types"
  add_foreign_key "proceeding_type_scope_limitations", "scope_limitations"
  add_foreign_key "proceeding_type_service_levels", "proceeding_types"
  add_foreign_key "proceeding_type_service_levels", "service_levels"
  add_foreign_key "threshold_waivers", "client_involvement_types"
  add_foreign_key "threshold_waivers", "matter_types"
end
