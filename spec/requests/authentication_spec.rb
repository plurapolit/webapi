# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Authentication requests', type: :request do
  let(:headers) { { 'CONTENT_TYPE': 'application/json' } }
  describe 'Sign up' do
    it 'does return a 201' do
      params = { user: {
        email: 'testuser@test.de', password: 'secret', first_name: 'Mr', last_name: 'Test'
      } }.to_json
      post '/api/users', params: params, headers: headers
      expect(response.status).to eq(201)
    end
    context 'when not giving the appropriate input' do
      it 'returns the correct error message for missing first_name' do
        params = { user: { email: 'testuser@test.de', password: 'secret', last_name: 'Test' } }.to_json
        post '/api/users', params: params, headers: headers
        expect(response.body).to include({ first_name: ["can't be blank"] }.to_json)
      end

      it 'returns the correct error message for missing last_name' do
        params = { user: { email: 'testuser@test.de', password: 'secret', first_name: 'Test' } }.to_json
        post '/api/users', params: params, headers: headers
        expect(response.body).to include({ last_name: ["can't be blank"] }.to_json)
      end

      it 'returns the correct error message for existing account' do
        create(:user, email: 'testuser@test.de')
        params = { user: {
          email: 'testuser@test.de', password: 'secret', first_name: 'Mr', last_name: 'Test'
        } }.to_json
        post '/api/users', params: params, headers: headers
        expect(response.body).to include({ email: ['has already been taken'] }.to_json)
      end
    end

    describe 'Sign in' do
      before do
        create(:user, email: 'testuser@test.de', password: 'secret')
      end
      it 'returns a 201' do
        params = { user: {
          email: 'testuser@test.de', password: 'secret', remember_me: 1
        } }.to_json
        post '/api/users/sign_in', headers: headers, params: params
        expect(response.status).to eq(201)
      end

      it 'returns a 401 with wrong password' do
        params = { user: {
          email: 'testuser@test.de', password: 'wrong-password', remember_me: 1
        } }.to_json
        post '/api/users/sign_in', headers: headers, params: params
        expect(response.status).to eq(401)
      end

      it 'returns a 401 with wrong email' do
        params = { user: {
          email: 'testuserwrong@test.de', password: 'secret', remember_me: 1
        } }.to_json
        post '/api/users/sign_in', headers: headers, params: params
        expect(response.status).to eq(401)
      end

      it 'includes a Bearer token' do
        params = { user: {
          email: 'testuser@test.de', password: 'secret', remember_me: 1
        } }.to_json
        post '/api/users/sign_in', headers: headers, params: params
        expect(response.headers).to include('Authorization')
      end
    end
  end
end
