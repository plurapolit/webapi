# frozen_string_literal: true

REGISTERED_USER_LIST_ID = 'a988d414-2d58-4a3f-9830-3f95679260d3'

class SendgridUserSyncJob < ActiveJob::Base
  include SuckerPunch::Job

  def perform(email:, first_name:, last_name:)
    @email = email
    @first_name = first_name
    @last_name = last_name

    response = sync_user_to_sendgrid
    return if response.code == '202'

    puts response.read_body
  end

  private

  def sync_user_to_sendgrid
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Put.new(url)
    request['authorization'] = "Bearer #{Rails.application.credentials.dig(:sendgrid_api)}"
    request['content-type'] = 'application/json'
    request.body = req_body

    http.request(request)
  end

  def url
    URI('https://api.sendgrid.com/v3/marketing/contacts')
  end

  def req_body
    {
      list_ids: [REGISTERED_USER_LIST_ID],
      contacts: [{ email: @email, first_name: @first_name, last_name: @last_name }]
    }.to_json
  end
end
