# frozen_string_literal: true

json.categories @categories do |category|
  json.category category, :id, :name, :created_at
  json.category_avatar url_for(category.avatar) if category.avatar.attached?
  json.panels category.panels do |panel|
    json.panel panel, :id, :title, :short_title, :slug, :description, :created_at
  end
end
