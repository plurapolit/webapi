# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Click Trackings requests', type: :request do
  let(:headers) { { 'CONTENT_TYPE': 'application/json' } }
  let(:region) { create :region }
  let(:category) { create :category, region: region }
  let!(:panel) { create :panel, category: category }
  let(:user) { create :user }
  let(:statement) { create :statement, panel: panel, user: user }

  context 'with a logged in User' do
    it 'can be sent' do
      post '/api/click_trackings', params: tracking_body(user.id)
      expect(response.status).to eq(201)
    end
  end
  context 'without logged in User' do
    it 'can be sent' do
      post '/api/click_trackings', params: tracking_body(nil)
      expect(response.status).to eq(201)
    end
  end
end

private

def tracking_body(user_id)
  {
    click_tracking: {
      user_id: user_id,
      statement_id: statement.id,
      event: 'twitter',
      information: nil
    }
  }
end
