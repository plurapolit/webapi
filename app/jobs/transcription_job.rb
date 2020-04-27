# frozen_string_literal: true

class TranscriptionJob < ActiveJob::Base
  include SuckerPunch::Job
  workers 4

  def perform(statement_id)
    puts 'Perform Job'
    statement = Statement.find(statement_id)
    job_name = SecureRandom.uuid
    source_url = statement.audio_file_file_link
    url = transcription_url(job_name, source_url)
    content = transcription_content(url)
    Transcription.create!(status: :pending, job_name: job_name, job_url: url, statement: statement, content: content)
  end

  private

  def transcription_url(job_name, source_url)
    start_job(job_name, source_url)

    while %w[COMPLETED FAILED].exclude? transcription_result(job_name)[:transcription_job][:transcription_job_status]
      puts 'job still running'
      sleep 5
    end
    transcription_result(job_name)['transcription_job']['transcript']['transcript_file_uri']
  end

  def start_job(job_name, source_url)
    client.start_transcription_job(
      transcription_job_name: job_name,
      media: {
        media_file_uri: source_url
      },
      media_format: 'mp3',
      language_code: 'de-DE'
    )
  end

  def client
    Aws::TranscribeService::Client.new(
      region: 'eu-central-1',
      credentials: credentials
    )
  end

  def credentials
    key = Rails.application.credentials.dig(:aws, :access_key_id)
    secret = Rails.application.credentials.dig(:aws, :secret_access_key)
    Aws::Credentials.new(key, secret)
  end

  def transcription_result(name)
    client.get_transcription_job(transcription_job_name: name)
  end

  def transcription_content(url)
    uri = URI(url)
    res = Net::HTTP.get(uri)
    JSON.parse(res)['results']['transcripts'][0]['transcript']
  end
end
