# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'organisation' do
  let(:organisation) { create :organisation }

  it 'has a name' do
    expect(organisation.name).to eq('Organisation')
  end

  it 'has a description' do
    expect(organisation.description).to eq('Das ist eine tolle Organisation')
  end

  context 'when created' do
    it 'has to have a name' do
      organisation.name = ''
      organisation_without_name = organisation.save
      expect(organisation_without_name).to eq(false)
    end

    it 'has to have a description' do
      organisation.description = ''
      organisation_without_description = organisation.save
      expect(organisation_without_description).to eq(false)
    end
  end
end
