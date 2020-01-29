# frozen_string_literal: true

module Api
  class FeedbacksController < ApplicationController
    respond_to :json

    SUCCESS_MESSAGE = 'Danke für dein Feedback!'

    def create
      feedback = Feedback.new(feedback_params)

      if feedback.save!
        render json: { msg: SUCCESS_MESSAGE }, status: :created
      else
        render json: feedback.errors, status: :unprocessable_entity
      end
    end

    private

    def feedback_params
      params.require(:feedback).permit(:description, :email)
    end
  end
end
