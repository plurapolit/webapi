# frozen_string_literal: true

json.categories @categories do |category|
  json.category category, :id, :name, :created_at
  json.category_avatar category.avatar.blob.key if category.avatar.attached?
  json.panels category.panels do |panel|
    json.panel panel, :id, :title, :short_title, :slug, :description, :created_at
    json.experts panel.statements.from_experts.shuffle do |statement|
      json.full_name statement.user.full_name
      json.avatar statement.user.avatar.blob.key if statement.user.avatar.attached?
    end
  end
end
