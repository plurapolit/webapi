# frozen_string_literal: true

class Panel < ApplicationRecord
  belongs_to :category
  validates :title, :short_title, :description, presence: true
end
