# frozen_string_literal: true

class AgeRange < ApplicationRecord
  acts_as_paranoid
  has_many :users

  def range
    start_age..end_age
  end

  def range_as_text
    return "Bis #{end_age}" if start_age.nil?

    return "Ab #{start_age}" if end_age.nil?

    "#{start_age} - #{end_age}"
  end
end
