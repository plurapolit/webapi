# frozen_string_literal: true

class Category < ApplicationRecord
  validates :name, :background_color, presence: true
  belongs_to :region
  has_many :panels, dependent: :destroy
  has_one_attached :avatar
  delegate :name, to: :region, prefix: true
  validates :avatar, content_type: {
    in: ['image/jpeg', 'image/jpg', 'image/png', 'image/svg+xml'],
    message: 'is not a valid image type (Choose .jpg, .jpeg, .png or .svg)'
  }
end
