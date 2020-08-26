# frozen_string_literal: true

class Region < ApplicationRecord
  has_many :categories
end
