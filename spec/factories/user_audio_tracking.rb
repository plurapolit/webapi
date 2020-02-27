# frozen_string_literal: true

FactoryBot.define do
  factory :user_audio_tracking do
    current_position_in_seconds { 16 }
    playtime_in_seconds { 30 }
  end
end
