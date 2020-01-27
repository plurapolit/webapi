# frozen_string_literal: true

class Like < ApplicationRecord
  belongs_to :statement
  belongs_to :user

  validates :statement, presence: true
  validates :user, presence: true

  validates :statement_id, uniqueness: { scope: :user_id }
end
