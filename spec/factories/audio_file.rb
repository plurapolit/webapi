# frozen_string_literal: true

FactoryBot.define do
  factory :audio_file do
    duration_seconds { 90 }
    file_link { 'https://mymp3.com/file.mp3' }
  end
end
