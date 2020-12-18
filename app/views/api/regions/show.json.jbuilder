# frozen_string_literal: true

json.region @region, :id, :name
json.categories @region.categories do |category|
  json.category category, :id, :name, :background_color
  json.panels category.panels.order(updated_at: :desc), :id
end
