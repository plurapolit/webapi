# frozen_string_literal: true

class ClickTracking < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :statement, optional: true
end
