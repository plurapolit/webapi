# frozen_string_literal: true

json.category @category
json.category_avatar attached_image_url(@category.avatar)
json.panel @panel, :id, :title, :short_title, :font_color, :slug, :description, :is_battle?, :created_at
json.panel_avatar attached_image_url(@panel.avatar)

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
  if statement.transcription.present? && statement.transcription.accepted?
    json.transcription statement.transcription, :content
  end
  json.intro statement.intro, :audio_file_link, :file_name if statement.intro.present?
  user = statement.user
  json.user user, :full_name, :role, :biography, :website_link, :twitter_handle, :facebook_handle, :linkedin_handle
  if user.organisation.present?
    json.organisation do
      json.name user.organisation.name
      json.avatar attached_image_url(user.organisation.avatar)
    end
  end
  json.user_avatar attached_image_url(user.avatar)
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
  json.user_avatar attached_image_url(user.avatar)
end
