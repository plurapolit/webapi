# frozen_string_literal: true

module ApplicationHelper
  def attached_image_url(attachment)
    return unless attachment.attached?

    if Rails.env.production?
      ix_image_url(attachment.key, source: 'production')
    elsif Rails.env.staging?
      ix_image_url(attachment.key, source: 'staging')
    else
      rails_blob_url(attachment)
    end
  end
end
