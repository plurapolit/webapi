# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :sender, class_name: 'Statement'
  belongs_to :recipient, class_name: 'Statement'
end
