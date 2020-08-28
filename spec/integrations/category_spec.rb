# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Category' do
  let(:region) { create :region }
  let(:category) { create :category, region: region }

  it 'has a name' do
    expect(category.name).to eq('Test Category')
  end

  context 'when created' do
    it 'has to have a name' do
      category.name = ''
      category_without_name = category.save
      expect(category_without_name).to eq(false)
    end
  end
end
