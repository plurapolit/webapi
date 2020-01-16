# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Home Page Features', type: :feature do
  before do
    sign_in_admin
  end

  it 'is accessible' do
    visit '/'
    expect(status).to eq(200)
  end
end
