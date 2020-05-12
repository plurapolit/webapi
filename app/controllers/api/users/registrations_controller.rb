# frozen_string_literal: true

module Api
  module Users
    class RegistrationsController < Devise::RegistrationsController
      # include Devise::Mailer
      respond_to :json

      SUCCESS_MESSAGE = 'Erfolgreich angemeldet! Bitte bestätige deine E-Mail Adresse in deinem E-Mail Postfach.'

      # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
      def create
        build_resource(sign_up_params)
        resource.save
        if resource.persisted?
          if resource.active_for_authentication?
            SendgridUserSyncJob.perform_later(
              email: resource.email,
              first_name: resource.first_name,
              last_name: resource.last_name
            )
            sign_up(resource_name, resource)
            render_create_json
          else
            expire_data_after_sign_in!
            respond_with resource, location: after_inactive_sign_up_path_for(resource)
          end
        else
          clean_up_passwords resource
          set_minimum_password_length
          respond_with resource
        end
      end
      # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

      private

      def current_token
        request.env['warden-jwt_auth.token']
      end

      def render_create_json
        render json: { user: resource,
                       token: current_token,
                       msg: SUCCESS_MESSAGE }.to_json, status: :created
      end
    end
  end
end
