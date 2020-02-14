# frozen_string_literal: true

class UserMailer < Devise::Mailer
  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
  default template_path: 'devise/mailer' # to make sure that your mailer uses the devise views

  def confirmation_instructions(record, token, opts = {})
    @token = token
    @full_name = "#{record.first_name} #{record.last_name}"
    opts[:subject] = 'Willkommen bei PluraPolit'
    devise_mail(record, :confirmation_instructions, opts)
  end

  def reset_password_instructions(record, token, opts = {})
    @full_name = "#{record.first_name} #{record.last_name}"
    @reset_password_url = reset_password_url(token)
    opts[:subject] = 'PluraPolit Passwort zurücksetzen'
    devise_mail(record, :reset_password_instructions, opts)
  end

  def password_change(record, opts = {})
    @full_name = "#{record.first_name} #{record.last_name}"
    opts[:subject] = 'Dein PluraPolit Passwort wurde geändert'
    devise_mail(record, :password_change, opts)
  end

  private

  def reset_password_url(token)
    return "https://staging.plurapolit.de/reset_password/#{token}" if Rails.env.staging?
    return "http://localhost:3000/reset_password/#{token}" if Rails.env.development?

    "https://plurapolit.de/reset_password/#{token}"
  end
end
