# frozen_string_literal: true

module ApplicationHelper
  def attached_image_url(attachment)
    return unless attachment.attached?

    if Rails.env.production?
      ix_image_url('plurapolit.imgix.net', attachment.key)
    elsif Rails.env.staging?
      ix_image_url('plurapolit-staging.imgix.net', attachment.key)
    else
      rails_blob_url(attachment)
    end
  end
end
