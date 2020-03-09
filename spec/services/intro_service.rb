# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Intro service' do
  before do
    @intro_service = IntroService.new(
      bucket_name: 'plurapolit-webapi-dev-media',
      dir_name: 'intros',
      first_name: 'Test',
      last_name: 'Dummy',
      party: 'Test Party',
      date: '11. Dezember 2011'
    )
  end

  it 'can be initialized' do
    expect(@intro_service).to be_an_instance_of IntroService
  end

  it 'has a filename' do
    service_file_name = @intro_service.file_name
    expect(service_file_name).to be_a String
  end

  describe '#create' do
    it 'returns the correct link to the intro mp3' do
      expect(@intro_service.create_intro['link']).to eq(
        'https://plurapolit-webapi-dev-media.s3.eu-central-1.amazonaws.com/intros/' \
        "#{@intro_service.file_name}.mp3"
      )
    end
  end
end
