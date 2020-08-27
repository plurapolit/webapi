# frozen_string_literal: true

class Region < ApplicationRecord
  has_many :categories
  validates :name, presence: true
end
