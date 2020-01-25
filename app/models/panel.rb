# frozen_string_literal: true

class Panel < ApplicationRecord
  belongs_to :category
  delegate :name, to: :category, prefix: true
  has_many :statements
  has_one_attached :avatar
  validates :avatar, content_type: {
    in: ['image/jpeg', 'image/jpg', 'image/png', 'image/svg+xml'],
    message: 'is not a valid image type (Choose .jpg, .jpeg, .png or .svg)'
  }
  validates :title, :short_title, :description, :font_color, presence: true

  def slug
    "#{created_at.year}-#{short_title.downcase.split.join('-')}"
  end
end
