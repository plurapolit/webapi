# frozen_string_literal: true

class Transcription < ApplicationRecord
  belongs_to :statement

  enum status: { pending: 0, accepted: 1 }
end
