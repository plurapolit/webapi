# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include ActionController::MimeResponds
  protect_from_forgery with: :exception, unless: -> { request.format.json? }
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name age_range_id])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name age_range_id])
  end
end
