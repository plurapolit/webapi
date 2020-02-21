# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Statements requests', type: :request do
  let(:headers) { { 'CONTENT_TYPE': 'application/json' } }
  let(:user) { create :user }
  let!(:different_user) { create :user, email: 'different@email.com' }
  let(:category) { create :category }
  let!(:panel) { create :panel, category: category }
  let(:statement) { create :statement, user: user, panel: panel }
  let!(:audio_file) { create :audio_file, statement: statement }

  describe 'creation' do
    it 'successfully creates a statement' do
      post '/api/user_audio_trackings', headers: headers, params: audio_tracking_body.to_json
      expect(response.status).to eq(201)
    end

    it 'successfully creates a statement even without user_id present' do
      audio_tracking_body[:user_id] = nil
      post '/api/user_audio_trackings', headers: headers, params: audio_tracking_body.to_json
      expect(response.status).to eq(201)
    end
  end
end

private

def audio_tracking_body
  {
    user_id: user.id,
    statement_id: statement.id,
    current_position_in_seconds: 80,
    seconds_listened: 80
  }
end
