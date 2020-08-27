# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Region' do
  let(:region) { create :region }

  it 'has a name' do
    expect(region.name).to eq('Test Region')
  end

  context 'when created' do
    it 'has to have a name' do
      region.name = ''
      region_without_name = region.save
      expect(region_without_name).to eq(false)
    end
  end
end
