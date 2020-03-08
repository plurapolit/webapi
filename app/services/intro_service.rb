# frozen_string_literal: true

INTRO_LAMBDA_URL = 'https://pxva371qo6.execute-api.eu-central-1.amazonaws.com/prod/polly/createintro'

class IntroService
  attr_reader :file_name
  # rubocop:disable Metrics/ParameterLists
  def initialize(bucket_name:, dir_name:, first_name:, last_name:, party:, date:)
    @bucket_name = bucket_name
    @dir_name = dir_name
    @first_name = first_name
    @last_name = last_name
    @party = party
    @date = date
    @file_name = random_file_name
  end
  # rubocop:enable Metrics/ParameterLists

  def create_intro
    JSON.parse(http_request.body)
  rescue StandardError => e
    e
  end

  private

  def random_file_name
    SecureRandom.uuid
  end

  def http_request
    uri = URI(INTRO_LAMBDA_URL)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    req = Net::HTTP::Post.new(uri.path, 'Content-Type': 'application/json', 'Accept': '*/*')
    req.body = {
      bucketName: @bucket_name, dirName: @dir_name,
      fileName: @file_name, firstName: @first_name, lastName: @last_name,
      party: @party, date: @date
    }.to_json
    http.request(req)
  end
end
