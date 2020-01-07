# frozen_string_literal: true

class Category < ApplicationRecord
  validates :name, presence: true
  has_one_attached :avatar
end
