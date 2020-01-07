# frozen_string_literal: true

class Panel < ApplicationRecord
  belongs_to :category
  validates :title, :short_title, :description, presence: true
  has_one_attached :avatar
end
