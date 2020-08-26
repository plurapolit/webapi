# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User Audio Tracking' do
  let(:region) { create :region }
  let(:category) { create :category, region: region }
  let(:panel) { create :panel, category: category }
  let(:user) { create :user }
  let(:statement) { create :statement, user: user, panel: panel }
  let!(:audio_file) { create :audio_file, statement: statement }
  let(:user_audio_tracking) { create :user_audio_tracking, user: user, statement: statement }

  it 'can be associated with a user' do
    expect(user_audio_tracking.user).to eq(user)
  end

  it 'does not have to be associated with a user' do
    tracking_without_user = build :user_audio_tracking, statement: statement
    expect(tracking_without_user.save).to be_truthy
  end

  it 'is associated with a statement' do
    expect(user_audio_tracking.statement).to eq(statement)
  end

  it 'by default is not classified as intro' do
    expect(user_audio_tracking.is_intro).to be(false)
  end

  it 'can be classified as intro' do
    tracking_as_intro = build :user_audio_tracking, statement: statement, is_intro: true
    tracking_as_intro.save
    expect(tracking_as_intro.is_intro).to be(true)
  end
end
