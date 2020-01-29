# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Feedback requests', type: :request do
  let(:headers) { { 'CONTENT_TYPE': 'application/json' } }

  it 'successfully creates feedback' do
    post '/api/feedbacks', params: feedback_body, headers: headers
    expect(status).to eq(201)
  end

  private

  def feedback_body
    {
      feedback: {
        description: 'this is lit',
        email: 'me@robin.com'
      }
    }.to_json
  end
end
