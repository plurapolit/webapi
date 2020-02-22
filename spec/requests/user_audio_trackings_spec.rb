# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User Audio Tracking requests', type: :request do
  let(:headers) { { 'CONTENT_TYPE': 'application/json' } }
  let(:user) { create :user }
  let!(:different_user) { create :user, email: 'different@email.com' }
  let(:category) { create :category }
  let!(:panel) { create :panel, category: category }
  let(:statement) { create :statement, user: user, panel: panel }
  let!(:audio_file) { create :audio_file, statement: statement }

  describe 'creation' do
    it 'successfully creates a tracking entry' do
      post '/api/user_audio_trackings', headers: headers, params: audio_tracking_body.to_json
      expect(response.status).to eq(201)
    end

    it 'successfully creates a tracking entry even without user_id present' do
      audio_tracking_body[:user_id] = nil
      post '/api/user_audio_trackings', headers: headers, params: audio_tracking_body.to_json
      expect(response.status).to eq(201)
    end
  end

  describe 'updating' do
    before do
      @tracking = create :user_audio_tracking, statement: statement, user: user
      put "/api/user_audio_trackings/#{@tracking.id}", headers: headers, params: update_tracking_body.to_json
    end

    it 'successfully updates a tracking entry' do
      updated_tracking = UserAudioTracking.find(@tracking.id)
      expect(updated_tracking.current_position_in_seconds).to eq(90)
    end

    it 'returns the correct status code' do
      expect(response.status).to eq(204)
    end
  end
end

private

def audio_tracking_body
  {
    user_id: user.id,
    statement_id: statement.id,
    current_position_in_seconds: 80,
    playtime_in_seconds: 80
  }
end

def update_tracking_body
  {
    current_position_in_seconds: 90,
    playtime_in_seconds: 90
  }
end
