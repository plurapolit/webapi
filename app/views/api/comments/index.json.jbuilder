# frozen_string_literal: true

json.statement @statement
json.comments @accepted_comments do |comment|
  json.comment comment.sender, :id, :quote, :created_at
  json.audio_file comment.sender.audio_file, :file_link, :duration_seconds
  user = comment.sender.user
  json.user user, :full_name, :role
  json.age_range user.age_range, :range_as_text if user.age_range.present?
  json.organisation user.organisation :name, :avatar if user.organisation.present?
  json.user_avatar user.avatar.blob.key if user.avatar.attached?
end
