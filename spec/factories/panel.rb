# frozen_string_literal: true

FactoryBot.define do
  factory :panel do
    title { 'Test Panel' }
    short_title { 'Kurz Title Panel' }
    description { 'Das hier ist eine Beschreibung' }
  end
end
