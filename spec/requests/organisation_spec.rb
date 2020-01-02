# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Organisation request', type: :request do
  let(:organisation) { create :organisation }

  it 'returns the requested organisation' do
    get "/organisations/#{organisation.id}"
    organisation_hash = { id: organisation.id, name: 'Organisation', description: 'Das ist eine tolle Organisation' }
    expect(parse_json(response.body)).to include(organisation_hash)
  end
end
