# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Organisation Features', type: :feature do
  it 'can be created' do
    visit new_organisation_path
    fill_in 'name', with: 'New organisation'
    fill_in 'description', with: 'New description'
    click 'Save'
    expect(page).to contain('Successfully created')
  end
end
