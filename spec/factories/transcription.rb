# frozen_string_literal: true

FactoryBot.define do
  factory :transcription do
    content { 'I am just the content' }
    status { 'pending' }
    job_url { 'https://test.de' }
    job_name { '123456' }
  end
end
