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
end
