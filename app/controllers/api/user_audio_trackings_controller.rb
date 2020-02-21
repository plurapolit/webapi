# frozen_string_literal: true

module Api
  class UserAudioTrackingsController < ApplicationController
    respond_to :json

    def create
      audio_tracking = UserAudioTracking.new(user_audio_tracking_params)
      if audio_tracking.save!
        head :created
      else
        render json: audio_tracking.errors, status: :unprocessable_entity
      end
    end

    private

    def user_audio_tracking_params
      params.require(:user_audio_tracking).permit(
        :user_id, :statement_id, :current_position_in_seconds, :seconds_listened
      )
    end
  end
end
