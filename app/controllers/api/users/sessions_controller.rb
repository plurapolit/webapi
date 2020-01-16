# frozen_string_literal: true

module Api
  module Users
    class SessionsController < Devise::SessionsController
      respond_to :json

      def create
        super do
          render json: { user: current_user,
                         token: current_token }.to_json, status: 201
          return
        end
      end

      private

      def current_token
        request.env['warden-jwt_auth.token']
      end
    end
  end
end
