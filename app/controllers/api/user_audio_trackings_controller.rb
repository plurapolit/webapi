# frozen_string_literal: true

module Api
  class UserAudioTrackingsController < ApplicationController
    respond_to :json

    def create
      audio_tracking = UserAudioTracking.new(user_audio_tracking_params)
      if audio_tracking.save!
        render json: audio_tracking, status: :created
      else
        render json: audio_tracking.errors, status: :unprocessable_entity
      end
    end

    def update
      audio_tracking = UserAudioTracking.find(params[:id])
      if audio_tracking.update!(user_audio_tracking_params)
        head :no_content
      else
        render json: audio_tracking.errors, status: :unprocessable_entity
      end
    end

    private

    def user_audio_tracking_params
      params.require(:user_audio_tracking).permit(
        :user_id, :statement_id, :current_position_in_seconds, :playtime_in_seconds, :is_intro
      )
    end
  end
end
