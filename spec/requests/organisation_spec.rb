# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Organisation request', type: :request do
  let!(:organisation) { create :organisation }

  describe 'GET' do
    context 'when requesting a single organisation' do
      it 'returns the requested organisation' do
        get "/organisations/#{organisation.id}"
        organisation_hash = { name: 'Organisation', description: 'Das ist eine tolle Organisation' }
        expect(parse_json(response.body).with_indifferent_access).to include(organisation_hash)
      end
    end

    context 'when requesting all organisation' do
      it 'returns all the requested organisations' do
        Organisation.create(name: 'Organisation2', description: 'Weitere Organisation')
        get '/organisations'
        expect(parse_json(response.body).length).to eq 2
      end
    end
  end
end
