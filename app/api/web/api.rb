# frozen_string_literal: true

module Web
  class Api < Grape::API
    mount Web::V1::Categories
  end
end
