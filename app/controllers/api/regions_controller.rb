module Api
    class RegionsController < ApplicationController
      respond_to :json

      def index
        @regions = Region.order(updated_at: :desc)
      end

      def show
        @region = Region.find(params[:id])
      end
    end
end