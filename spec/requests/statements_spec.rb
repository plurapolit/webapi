# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Statements requests', type: :request do
  let(:headers) { { 'CONTENT_TYPE': 'application/json' } }
  let(:user) { create :user }
  let!(:different_user) { create :user, email: 'different@email.com' }
  let(:region) { create :region }
  let(:category) { create :category, region: region }
  let!(:panel) { create :panel, category: category }

  describe 'creation' do
    it 'successfully creates a statement' do
      auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)
      post '/api/statements', headers: auth_headers, params: create_statement_body
      expect(response.status).to eq(201)
    end
  end

  describe 'deletion' do
    it 'successfully deletes a statement' do
      statement = create :statement, panel: panel, user: user
      auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)
      delete "/api/statements/#{statement.id}", headers: auth_headers
      expect(response.status).to eq(204)
    end

    it 'cannot delete a statement of another user' do
      statement = create :statement, panel: panel, user: user
      auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, different_user)
      delete "/api/statements/#{statement.id}", headers: auth_headers
      expect(response.status).to eq(403)
    end
  end
end

private

def create_statement_body
  {
    statement: {
      panel_id: panel.id,
      quote: 'this is a quote'
    },
    audio_file: {
      file_link: 'https://mysong.de/test.mp3',
      duration_seconds: 99
    }
  }.to_json
end
