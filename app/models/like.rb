# frozen_string_literal: true

class Like < ApplicationRecord
  belongs_to :statement
  belongs_to :user
end
