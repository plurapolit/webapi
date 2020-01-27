# frozen_string_literal: true

class User < ApplicationRecord
  belongs_to :organisation, optional: true
  belongs_to :age_range, optional: true
  delegate :name, to: :organisation, prefix: true, allow_nil: true
  enum role: { default: 0, expert: 1 }
  has_many :likes
  has_many :statements

  has_one_attached :avatar
  validates :avatar, content_type: {
    in: ['image/jpeg', 'image/jpg', 'image/png', 'image/svg+xml'],
    message: 'is not a valid image type (Choose .jpg, .jpeg, .png or .svg)'
  }
  validates :first_name, :last_name, presence: true
  validates :organisation, presence: true, if: -> { expert? }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtBlacklist

  self.skip_session_storage = %i[http_auth params_auth]

  def full_name
    "#{first_name} #{last_name}"
  end

  def avatar_service_link
    return unless avatar.attached?

    blob = avatar.blob.key
    if Rails.env.production?
      "https://plurapolit-webapi-prod-media.s3.eu-central-1.amazonaws.com/#{blob}"
    elsif Rails.env.staging?
      "https://plurapolit-webapi-staging-media.s3.eu-central-1.amazonaws.com/#{blob}"
    else
      "https://plurapolit-webapi-dev-media.s3.eu-central-1.amazonaws.com/#{blob}"
    end
  end
end
