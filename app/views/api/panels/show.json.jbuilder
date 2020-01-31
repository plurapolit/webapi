# frozen_string_literal: true

json.category @category
json.category_avatar_key @category.avatar.blob.key if @category.avatar.attached?
json.panel @panel, :id, :title, :short_title, :font_color, :slug, :description, :created_at
json.panel_avatar_key @panel.avatar.blob.key if @panel.avatar.attached?

num_experts = 1
json.expert_statements @statements_from_experts do |statement|
  json.index num_experts
  num_experts += 1
  json.statement statement, :id, :quote, :created_at
  json.number_of_comments Comment.of_statement(statement).count
  json.likes do
    json.total_likes statement.likes.count
    json.liked_by_current_user statement.liked_by?(current_user)
  end
  json.statement_audio_file statement.audio_file, :file_link, :duration_seconds
  user = statement.user
  json.user user, :full_name, :role, :biography
  if user.organisation.present?
    json.organisation do
      json.name user.organisation.name
      json.avatar_key user.organisation.avatar.blob.key if user.organisation.avatar.attached?
    end
  end
  json.user_avatar_key user.avatar.blob.key if user.avatar.attached?
end

num_community = 1
json.community_statements @statements_from_community do |statement|
  json.index num_community
  num_community += 1
  json.statement statement, :id, :quote, :created_at
  json.number_of_comments Comment.of_statement(statement).count
  json.likes do
    json.total_likes statement.likes.count
    json.liked_by_current_user statement.liked_by?(current_user)
  end
  json.statement_audio_file statement.audio_file, :file_link, :duration_seconds
  user = statement.user
  json.user user, :full_name, :role
  json.age_range user.age_range, :range_as_text if user.age_range.present?
  json.user_avatar_key user.avatar.blob.key if user.avatar.attached?
end
