# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Pages Features', type: :feature do
  describe 'Home Page' do
    it 'is accessible' do
      sign_in_admin
      visit '/'
      expect(status_code).to eq(200)
    end
  end

  describe 'Health Check' do
    it 'is healthy' do
      create(:age_range_16to28)
      visit '/healthcheck'
      expect(page.status_code).to eq(200)
    end
  end
end
