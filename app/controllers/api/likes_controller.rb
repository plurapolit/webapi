# frozen_string_literal: true

module Api
  class LikesController < ApplicationController
    respond_to :json

    def create
      authenticate_user!

      @statement = Statement.find(params[:statement_id])
      Like.create!(
        user: current_user,
        statement: @statement
      )
      head :created
    end

    def destroy
      authenticate_user!

      @statement = Statement.find(params[:statement_id])
      @like = Like.find_by(statement: @statement, user: current_user)
      @like.destroy!
    end
  end
end
