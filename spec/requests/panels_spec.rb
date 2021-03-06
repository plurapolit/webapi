# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Panels requests', type: :request do
  let(:headers) { { 'CONTENT_TYPE': 'application/json' } }
  let(:region) { create :region }
  let(:category) { create :category, region: region }
  let!(:panel) { create :panel, category: category }

  describe 'index' do
    it 'shows all panels' do
      create :panel, category: category, title: 'second panel'
      get '/api/panels'
      expect(JSON.parse(body)['categories'].first['panels'].length).to eq(2)
    end
  end

  describe 'show' do
    it 'shows the panel information' do
      get "/api/panels/#{panel.id}"
      expect(JSON.parse(body)['panel']).to include('description' => 'Das hier ist eine Beschreibung')
    end

    it 'shows all the accepted statements' do
      user = create(:user)
      statement = create :statement, panel: panel, user: user, status: 'accepted'
      create(:audio_file, statement: statement)
      get "/api/panels/#{panel.id}"
      expect(JSON.parse(body)['community_statements'].length).to eq 1
    end
  end
end
