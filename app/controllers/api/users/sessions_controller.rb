# frozen_string_literal: true

module Api
  module Users
    class SessionsController < Devise::SessionsController
      respond_to :json

      SUCCESS_MESSAGE = 'Erfolgreich angemeldet!'

      def create
        super do
          render json: { user: current_user,
                         token: current_token,
                         msg: SUCCESS_MESSAGE }.to_json, status: :created
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
