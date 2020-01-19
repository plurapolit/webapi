# frozen_string_literal: true

module Api
  class StatementsController < ApplicationController
    respond_to :json

    SUCCESS_CREATE_MESSAGE = 'Danke für deine Einsendung! Wir werden dein Statement in den nächsten Stunden überprüfen.'
    SUCCESS_DELETE_MESSAGE = 'Dein Statement wurde erfolgreich gelöscht.'

    def create
      authenticate_user!
      statement = Statement.new(user: current_user, panel: panel, quote: quote)
      statement.build_audio_file(audio_file_params)

      if statement.save!
        statement.audio_file.save!
        render json: created_json(statement), status: :created
      else
        render json: statement.errors, status: :unprocessable_entity
      end
    end

    def destroy
      authenticate_user!

      if statement_from_current_user.destroy!
        render json: {
          message: SUCCESS_DELETE_MESSAGE
        }.to_json, status: :no_content
      else
        render json: statement_from_current_user.errors, status: :unprocessable_entity
      end
    rescue ActiveRecord::RecordNotFound
      forbidden
    end

    private

    def panel
      Panel.find(params.dig('statement', 'panel_id'))
    end

    def quote
      params[:statement][:quote]
    end

    def created_json(statement)
      { statement: statement, audio_file: statement.audio_file, message: SUCCESS_CREATE_MESSAGE }.to_json
    end

    def audio_file_params
      {
        file_link: params[:audio_file][:file_link],
        duration_seconds: params[:audio_file][:duration_seconds]
      }
    end

    def statement_from_current_user
      current_user.statements.find(params[:id])
    end

    def forbidden
      head :forbidden
    end
  end
end
