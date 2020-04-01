# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Comments requests', type: :request do
  let(:headers) { { 'CONTENT_TYPE': 'application/json' } }
  let(:category) { create :category }
  let!(:panel) { create :panel, category: category }
  let(:recipient_user) { create :user }
  let(:statement) { create :statement, panel: panel, user: recipient_user }
  let(:sender) { create :user, email: 'sender@email.com' }

  describe 'index' do
    it 'shows all comments for a specific statement' do
      first_comment = create(:statement, panel: panel, user: sender, status: 'accepted')
      seconds_comment = create(:statement, panel: panel, user: sender, status: 'accepted')
      create :audio_file, statement: first_comment
      create :audio_file, statement: seconds_comment
      create(:comment, recipient: statement, sender: first_comment)
      create(:comment, recipient: statement, sender: seconds_comment)
      get "/api/statements/#{statement.id}/comments"
      expect(JSON.parse(body)['comments'].length).to eq(2)
    end

    it 'works with 0 comments' do
      get "/api/statements/#{statement.id}/comments"
      expect(response.status).to eq(204)
    end
  end

  describe 'creation' do
    it 'successfully creates a comment' do
      auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, sender)
      post "/api/statements/#{statement.id}/comments", headers: auth_headers, params: create_comment_body
      expect(response.status).to eq(201)
    end

    it 'can be a text comment' do
      auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, sender)
      post "/api/statements/#{statement.id}/comments", headers: auth_headers, params: create_text_comment_body
      expect(response.status).to eq(201)
    end
  end

  describe 'deletion' do
    it 'successfully deletes a comment' do
      comment_statement = create(:statement, panel: panel, user: sender)
      comment = create(:comment, sender: comment_statement, recipient: statement)
      auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, sender)
      delete "/api/statements/#{statement.id}/comments/#{comment.id}", headers: auth_headers
      expect(response.status).to eq(204)
    end

    it 'cannot delete a comment of another user' do
      comment_statement = create(:statement, panel: panel, user: sender)
      comment = create(:comment, sender: comment_statement, recipient: statement)
      auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, recipient_user)
      delete "/api/statements/#{statement.id}/comments/#{comment.id}", headers: auth_headers
      expect(response.status).to eq(403)
    end
  end
end

private

def create_comment_body
  {
    comment: {
      quote: 'this is a quote'
    },
    audio_file: {
      file_link: 'https://mysong.de/test.mp3',
      duration_seconds: 99
    }
  }.to_json
end

def create_text_comment_body
  {
    comment: {
      quote: ''
    },
    text_record: {
      content: 'I respectfully am a ball.'
    }
  }.to_json
end
