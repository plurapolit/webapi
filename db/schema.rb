# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_03_11_171921) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "age_ranges", force: :cascade do |t|
    t.integer "start_age"
    t.integer "end_age"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_age_ranges_on_deleted_at"
  end

  create_table "audio_files", force: :cascade do |t|
    t.string "file_link"
    t.integer "duration_seconds"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "statement_id", null: false
    t.index ["statement_id"], name: "index_audio_files_on_statement_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "background_color"
  end

  create_table "comments", force: :cascade do |t|
    t.bigint "sender_id", null: false
    t.bigint "recipient_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_comments_on_deleted_at"
    t.index ["recipient_id"], name: "index_comments_on_recipient_id"
    t.index ["sender_id"], name: "index_comments_on_sender_id"
  end

  create_table "feedbacks", force: :cascade do |t|
    t.string "email"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "intros", force: :cascade do |t|
    t.string "audio_file_link"
    t.string "file_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "jwt_blacklists", force: :cascade do |t|
    t.string "jti"
    t.datetime "exp"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["jti"], name: "index_jwt_blacklists_on_jti"
  end

  create_table "likes", force: :cascade do |t|
    t.bigint "statement_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["statement_id"], name: "index_likes_on_statement_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "organisations", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "panels", force: :cascade do |t|
    t.bigint "category_id", null: false
    t.string "title"
    t.string "short_title"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "font_color"
    t.index ["category_id"], name: "index_panels_on_category_id"
  end

  create_table "statements", force: :cascade do |t|
    t.bigint "panel_id", null: false
    t.bigint "user_id", null: false
    t.text "quote"
    t.integer "status", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.bigint "intro_id"
    t.index ["deleted_at"], name: "index_statements_on_deleted_at"
    t.index ["intro_id"], name: "index_statements_on_intro_id"
    t.index ["panel_id"], name: "index_statements_on_panel_id"
    t.index ["user_id"], name: "index_statements_on_user_id"
  end

  create_table "user_audio_trackings", force: :cascade do |t|
    t.integer "current_position_in_seconds"
    t.integer "playtime_in_seconds"
    t.bigint "user_id"
    t.bigint "statement_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_intro", default: false
    t.index ["statement_id"], name: "index_user_audio_trackings_on_statement_id"
    t.index ["user_id"], name: "index_user_audio_trackings_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.bigint "organisation_id"
    t.integer "role", default: 0
    t.string "first_name"
    t.string "last_name"
    t.text "biography"
    t.string "twitter_handle"
    t.string "facebook_handle"
    t.string "linkedin_handle"
    t.string "website_link"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.bigint "age_range_id"
    t.index ["age_range_id"], name: "index_users_on_age_range_id"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["organisation_id"], name: "index_users_on_organisation_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "audio_files", "statements"
  add_foreign_key "likes", "statements"
  add_foreign_key "likes", "users"
  add_foreign_key "panels", "categories"
  add_foreign_key "statements", "intros"
  add_foreign_key "statements", "panels"
  add_foreign_key "statements", "users"
  add_foreign_key "user_audio_trackings", "statements"
  add_foreign_key "user_audio_trackings", "users"
  add_foreign_key "users", "organisations"
end
