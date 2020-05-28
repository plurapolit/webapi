# frozen_string_literal: true

module Api
  class ClickTrackingsController < ApplicationController
    respond_to :json

    def create
      tracking = ClickTracking.new(click_tracking_params)
      if tracking.save!
        render json: tracking, status: :created
      else
        render json: tracking.errors, status: :unprocessable_entity
      end
    end

    private

    def click_tracking_params
      params.require(:click_tracking).permit(:user_id, :statement_id, :event, :information)
    end
  end
end
