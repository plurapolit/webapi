# frozen_string_literal: true

FactoryBot.define do
  factory :age_range_xto15, class: 'AgeRange' do
    end_age { 15 }
  end

  factory :age_range_16to28, class: 'AgeRange' do
    start_age { 16 }
    end_age { 28 }
  end

  factory :age_range_29to44, class: 'AgeRange' do
    start_age { 29 }
    end_age { 44 }
  end

  factory :age_range_45to60, class: 'AgeRange' do
    start_age { 45 }
    end_age { 60 }
  end

  factory :age_range_60tox, class: 'AgeRange' do
    start_age { 60 }
  end
end
