# frozen_string_literal: true

class Organisation < ApplicationRecord
  validates :name, :description, presence: true
end
