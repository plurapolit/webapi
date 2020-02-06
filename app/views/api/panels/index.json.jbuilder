# frozen_string_literal: true

json.categories @categories do |category|
  json.category category, :id, :name, :background_color, :created_at
  json.category_avatar category.avatar.blob.key if category.avatar.attached?
  json.panels category.panels.order('updated_at DESC') do |panel|
    json.panel panel, :id, :title, :short_title, :font_color, :slug, :description, :created_at
    json.panel_avatar panel.avatar.blob.key if panel.avatar.attached?
    json.experts panel.statements.from_experts.shuffle do |statement|
      json.full_name statement.user.full_name
      json.avatar statement.user.avatar.blob.key if statement.user.avatar.attached?
      if statement.user.organisation.avatar.attached?
        json.organisation_avatar statement.user.organisation.avatar.blob.key
      end
      json.organisation_name statement.user.organisation.name
    end
  end
end
