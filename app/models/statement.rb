# frozen_string_literal: true

class Statement < ApplicationRecord
  acts_as_paranoid
  has_one :audio_file
  accepts_nested_attributes_for :audio_file
  has_one :sent_comment, class_name: 'Comment', foreign_key: 'sender_id'
  has_one :received_comment, class_name: 'Comment', foreign_key: 'recipient_id'
  has_many :likes

  belongs_to :panel
  belongs_to :user

  delegate :title, to: :panel, prefix: true
  delegate :file_link, to: :audio_file, prefix: true

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
end
