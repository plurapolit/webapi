# frozen_string_literal: true

module Api
  class RoomsController < ApplicationController
    respond_to :json
    before_action :authenticate_user!

    def index
      @rooms = current_user.rooms
      if @rooms.empty?
        head :no_content
      else
        render @rooms, status_code: :ok
      end
    end

    def create
      room = Room.new(room_params)
      if room.save!
        render json: room, status: :created
      else
        render json: room.errors, status: :unprocessable_entity
      end
    end

    private

    def room_params
      params.require(:room).permit(:name)
    end
  end
end
