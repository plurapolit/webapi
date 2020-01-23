# frozen_string_literal: true

json.category @category
json.category_avatar rails_blob_path(@category.avatar) if @category.avatar.attached?
json.panel @panel, :id, :title, :short_title, :slug, :description, :created_at
json.panel_avatar rails_blob_path(@panel.avatar) if @panel.avatar.attached?

json.expert_statements @statements_from_experts do |statement|
  json.statement statement, :id, :quote, :created_at
  json.number_of_comments Comment.of_statement(statement).count
  json.statement_audio_file statement.audio_file, :file_link, :duration_seconds
  user = statement.user
  json.user user, :full_name, :role
  if user.organisation.present?
    json.organisation do
      json.name user.organisation.name
      json.avatar rails_blob_path(user.organisation.avatar) if user.organisation.avatar.attached?
    end
  end
  json.user_avatar rails_blob_path(user.avatar) if user.avatar.attached?
end

json.community_statements @statements_from_community do |statement|
  json.statement statement, :id, :quote, :created_at
  json.number_of_comments Comment.of_statement(statement).count
  json.statement_audio_file statement.audio_file, :file_link, :duration_seconds
  user = statement.user
  json.user user, :full_name, :role
  json.age_range user.age_range, :range_as_text if user.age_range.present?
  json.user_avatar rails_blob_path(user.avatar) if user.avatar.attached?
end
