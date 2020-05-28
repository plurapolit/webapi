# frozen_string_literal: true

json.categories @categories do |category|
  json.category category, :id, :name, :background_color, :created_at
  json.category_avatar attached_image_url(category.avatar)
  json.panels category.panels.where(deactivated: false).order('updated_at DESC') do |panel|
    json.panel panel, :id, :title, :short_title, :font_color, :slug, :description, :is_battle?, :created_at
    json.panel_avatar attached_image_url(panel.avatar)
    json.experts panel.statements.from_experts.without_comments.shuffle do |statement|
      json.full_name statement.user.full_name
      json.avatar attached_image_url(statement.user.avatar)
      json.organisation_avatar attached_image_url(statement.user.organisation.avatar)
      json.organisation_name statement.user.organisation.name
    end
  end
end
