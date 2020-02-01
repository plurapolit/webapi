# frozen_string_literal: true

module Api
  module Users
    class ConfirmationsController < Devise::ConfirmationsController
      respond_to :json

      def show
        self.resource = resource_class.confirm_by_token(params[:confirmation_token])
        if resource.errors.empty?
          redirect_to 'https://plurapolit.de'
        else
          respond_with_navigational(resource.errors, status: :unprocessable_entity) { render :new }
        end
      end
    end
  end
end
