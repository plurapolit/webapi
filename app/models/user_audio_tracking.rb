# frozen_string_literal: true

class UserAudioTracking < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :statement
end
