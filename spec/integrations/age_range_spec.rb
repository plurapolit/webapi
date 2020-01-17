# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Age Range' do
  let(:age_range) { create :age_range_16to28 }

  it 'is a range' do
    expect(age_range.range).to be_a(Range)
  end

  it 'is the correct range' do
    expect(age_range.range).to eq(16..28)
  end

  it 'belongs to a user' do
    user = create(:user, age_range: age_range)
    expect(user.age_range.range).to eq(16..28)
  end

  describe 'Text Value' do
    it 'returns correct value for no start age' do
      until15 = create(:age_range_xto15)
      expect(until15.range_as_text).to eq('Bis 15')
    end

    it 'returns correct value for no end age' do
      from60 = create(:age_range_60tox)
      expect(from60.range_as_text).to eq('Ab 60')
    end

    it 'returns correct value for normal age' do
      expect(age_range.range_as_text).to eq('16 - 28')
    end
  end
end
