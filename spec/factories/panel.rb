# frozen_string_literal: true

FactoryBot.define do
  factory :panel do
    title { 'Test Panel' }
    short_title { 'Kurz Title Panel' }
    font_color { '#1a1844' }
    description { 'Das hier ist eine Beschreibung' }
  end
end
