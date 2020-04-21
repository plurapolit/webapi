# frozen_string_literal: true

json.statement @statement
json.comments @comments do |comment|
  json.comment comment.sender, :id, :quote, :created_at
  json.audio_file comment.sender.audio_file, :file_link, :duration_seconds if comment.sender.audio_file
  json.text_record comment.sender.text_record, :content if comment.sender.text_record
  json.intro comment.sender.intro, :audio_file_link, :file_name if comment.sender.intro.present?
  user = comment.sender.user
  json.likes do
    comment_likes_count = comment.sender.likes.count
    json.total_likes comment_likes_count
    json.most_liked_comment comment_likes_count == @like_count_of_most_liked_comment
    json.liked_by_current_user comment.sender.liked_by?(current_user)
  end
  json.user user, :full_name, :role
  if json.age_range.present?
    json.age_range do
      json.range user.age_range
      json.range_as_text user.age_range.range_as_text if user.age_range.present?
    end
  end
  if json.organisation.present?
    json.organisation do
      json.name user.organisation.name
      json.avatar attached_image_url(user.organisation.avatar)
    end
  end
  json.user_avatar attached_image_url(user.avatar)
end
