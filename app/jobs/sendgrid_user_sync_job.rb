# frozen_string_literal: true

REGISTERED_USER_LIST_ID = 'a988d414-2d58-4a3f-9830-3f95679260d3'

class SendgridUserSyncJob < ActiveJob::Base
  include SuckerPunch::Job

  def perform(email:, first_name:, last_name:)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Put.new(url)
    request['authorization'] = "Bearer #{Rails.application.credentials.dig(:sendgrid_api)}"
    request['content-type'] = 'application/json'
    request.body = req_body(email, first_name, last_name)

    http.request(request)
  end

  private

  def url
    URI('https://api.sendgrid.com/v3/marketing/contacts')
  end

  def req_body(email, first_name, last_name)
    {
      list_ids: [REGISTERED_USER_LIST_ID],
      contacts: [{ email: email, first_name: first_name, last_name: last_name }]
    }.to_json
  end
end
