# frozen_string_literal: true

class Organisation < ApplicationRecord
  validates :name, presence: true
end
