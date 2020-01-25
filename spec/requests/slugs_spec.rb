# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Slug requests', type: :request do
  let(:headers) { { 'CONTENT_TYPE': 'application/json' } }
  let(:category) { create :category }
  let!(:panel) { create :panel, category: category }

  describe 'index' do
    it 'shows all slugs' do
      create :panel, category: category, title: 'second panel'
      get '/api/slugs'
      expect(JSON.parse(body)['panels'].length).to eq(2)
    end
  end
end
