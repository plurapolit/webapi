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
end
