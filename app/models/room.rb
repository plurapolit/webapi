# frozen_string_literal: true

class Room < ApplicationRecord
  before_create :create_invite_code
  has_and_belongs_to_many :users

  private

  def create_invite_code
    self.invite_code = SecureRandom.alphanumeric(6)
  end
end
