# frozen_string_literal: true

class Statement < ApplicationRecord
  after_create :create_intro, unless: :text_comment?
  acts_as_paranoid
  has_one :audio_file, dependent: :destroy
  has_one :text_record, dependent: :destroy
  accepts_nested_attributes_for :audio_file, :text_record
  has_one :sent_comment, class_name: 'Comment', foreign_key: 'sender_id'
  has_one :received_comment, class_name: 'Comment', foreign_key: 'recipient_id'
  has_many :likes, dependent: :destroy
  has_many :user_audio_trackings, dependent: :destroy

  belongs_to :panel
  belongs_to :user
  belongs_to :intro, optional: true

  delegate :title, to: :panel, prefix: true
  delegate :file_link, to: :audio_file, prefix: true
  delegate :name, to: :organisation, prefix: true

  enum status: { pending: 0, accepted: 1, rejected: 2 }

  scope :from_experts, lambda {
    includes(user: [{ avatar_attachment: :blob }, { organisation: { avatar_attachment: :blob } }])
      .joins(:user)
      .where('users.role = 1')
  }

  scope :from_community, lambda {
    includes(user: [:age_range, { avatar_attachment: :blob }])
      .joins(:user)
      .where('users.role = 0')
  }

  scope :without_comments, lambda {
    left_outer_joins(:sent_comment)
      .where('comments.sender_id IS NULL')
  }

  scope :only_comments, lambda {
    joins(:sent_comment)
      .where('comments.sender_id IS NOT NULL')
  }

  scope :sorted_by_likes, lambda {
    left_outer_joins(:likes)
      .group('statements.id')
      .order('COUNT(likes.id) DESC')
  }

  def liked_by?(user)
    likes.exists?(user: user)
  end

  def create_intro
    created_intro = intro_service
    intro = Intro.create!(
      audio_file_link: created_intro['link'],
      file_name: created_intro['filename']
    )
    self.intro_id = intro.id
    save!
  end

  private

  def intro_service
    IntroService.new(
      bucket_name: bucket_name,
      dir_name: 'intros',
      first_name: user.first_name,
      last_name: user.last_name,
      party: (user.organisation_name if user.organisation),
      date: created_at.strftime('%d.%m.%Y')
    ).create_intro
  end

  def bucket_name
    return 'plurapolit-webapi-prod-media' if Rails.env.production?
    return 'plurapolit-webapi-staging-media' if Rails.env.staging?

    'plurapolit-webapi-dev-media'
  end

  def text_comment?
    text_record.present?
  end
end
