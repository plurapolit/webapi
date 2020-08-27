# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Regions requests', type: :request do
  let(:headers) { { 'CONTENT_TYPE': 'application/json' } }
  let(:region) { create :region }
  let(:category) { create :category, region: region }
  let!(:panel) { create :panel, category: category }

  describe 'index' do
      it 'shows all regions' do
        create(:region, name: 'Region 2')
        get '/api/regions'
        expect(JSON.parse(body)['regions'].size == 2)
      end
  end

  describe 'show' do
    before do
        get "/api/regions/#{region.id}"
    end

    it 'shows the region information' do
      expect(JSON.parse(body)['region']).to include('name' => 'Test Region')
    end
  end
end
