# frozen_string_literal: true

json.regions @regions do |region|
  json.region region, :id, :name
end
