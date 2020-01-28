# frozen_string_literal: true

class FeedbacksController < ApplicationController
  def index
    @feedbacks = Feedback.all
  end
end
