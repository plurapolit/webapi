# frozen_string_literal: true

module Api
  class PanelsController < ApplicationController
    respond_to :json

    def index
      @categories = Category.all.includes(
        { panels: [{ avatar_attachment: :blob }] },
        avatar_attachment: :blob
      )
    end

    # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    def show
      @panel = Panel.find(params[:id])
      @category = @panel.category
      @statements_from_experts = @panel.statements
                                       .includes(
                                         :audio_file,
                                         user: [
                                           { avatar_attachment: :blob },
                                           { organisation: { avatar_attachment: :blob } }
                                         ]
                                       )
                                       .accepted
                                       .without_comments
                                       .from_experts
                                       .shuffle

      @statements_from_community = @panel.statements
                                         .includes(:audio_file)
                                         .accepted
                                         .without_comments
                                         .from_community
                                         .sorted_by_likes
    end
    # rubocop:enable Metrics/MethodLength, Metrics/AbcSize
  end
end
