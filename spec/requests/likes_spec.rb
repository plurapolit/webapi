# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Likes requests', type: :request do
  let(:headers) { { 'CONTENT_TYPE': 'application/json' } }
  let(:region) { create :region }
  let(:category) { create :category, region: region }
  let!(:panel) { create :panel, category: category }
  let(:like_receiver) { create :user }
  let(:statement) { create :statement, panel: panel, user: like_receiver }
  let(:liker) { create :user, email: 'liker@email.com' }

  describe 'a User' do
    it 'can like a statement' do
      auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, liker)
      post "/api/statements/#{statement.id}/likes", headers: auth_headers
      expect(statement.likes.count).to eq(1)
    end

    it 'can unlike a statement' do
      auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, liker)
      create :like, statement: statement, user: liker
      delete "/api/statements/#{statement.id}/likes", headers: auth_headers
      expect(statement.likes.count).to eq(0)
    end
  end
end
