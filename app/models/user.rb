# frozen_string_literal: true

class User < ApplicationRecord
  after_create :sync_user_to_sendgrid, unless: :expert?
  belongs_to :organisation, optional: true
  belongs_to :age_range, optional: true
  delegate :name, to: :organisation, prefix: true, allow_nil: true
  enum role: { default: 0, expert: 1 }
  has_many :likes
  has_many :statements
  has_many :user_audio_trackings
  has_many :click_trackings
  has_and_belongs_to_many :rooms

  has_one_attached :avatar
  validates :avatar, content_type: {
    in: ['image/jpeg', 'image/jpg', 'image/png', 'image/svg+xml'],
    message: 'is not a valid image type (Choose .jpg, .jpeg, .png or .svg)'
  }
  validates :first_name, :last_name, presence: true
  validates :organisation, presence: true, if: -> { expert? }

  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtBlacklist

  self.skip_session_storage = %i[http_auth params_auth]

  def full_name
    "#{first_name} #{last_name}"
  end

  def sync_user_to_sendgrid
    SendgridUserSyncJob.perform_later(
      email: email,
      first_name: first_name,
      last_name: last_name
    )
  end
end
