# frozen_string_literal: true

class Comment < ApplicationRecord
  acts_as_paranoid

  belongs_to :sender, class_name: 'Statement'
  belongs_to :recipient, class_name: 'Statement'

  scope :of_statement, lambda { |statement|
    joins(:sender)
      .where(recipient: statement)
      .merge(Statement.accepted)
  }
end
