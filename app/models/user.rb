# frozen_string_literal: true

class User < ApplicationRecord
  belongs_to :organisation, optional: true
  delegate :name, to: :organisation, prefix: true, allow_nil: true
  enum role: { default: 0, expert: 1 }

  has_one_attached :avatar
  validates :avatar, content_type: {
    in: ['image/jpeg', 'image/jpg', 'image/png', 'image/svg+xml'],
    message: 'is not a valid image type (Choose .jpg, .jpeg, .png or .svg)'
  }
  validates :first_name, :last_name, :role, presence: true
  validates :email, presence: true, if: -> { default? }
  validates :organisation, presence: true, if: -> { expert? }
end
