# frozen_string_literal: true

module Api
  class CommentsController < ApplicationController
    respond_to :json

    SUCCESS_CREATE_MESSAGE = 'Danke für deine Einsendung! Wir werden dein Kommentar in den nächsten Stunden überprüfen.'
    SUCCESS_DELETE_MESSAGE = 'Dein Kommentar wurde erfolgreich gelöscht.'

    def index
      @statement = Statement.find(params[:statement_id])
      @accepted_comments = Comment.of_statement(@statement)
      render :index, status: :ok
    end

    def create
      authenticate_user!
      comment = Comment.new(recipient: recipient, sender: new_sender)
      if comment.save!
        render json: created_json(comment), status: :created
      else
        render json: comment.errors, status: :unprocessable_entity
      end
    end

    def destroy
      authenticate_user!
      if comment_from_current_user.destroy!
        render json: {
          message: SUCCESS_DELETE_MESSAGE
        }.to_json, status: :no_content
      else
        render json: comment_from_current_user.errors, status: :unprocessable_entity
      end
    rescue ActiveRecord::RecordNotFound
      forbidden
    end

    private

    def recipient
      Statement.find(params[:statement_id])
    end

    def new_sender
      statement = Statement.new(user: current_user, panel: recipient.panel, quote: params[:comment][:quote])
      statement.build_audio_file(audio_file_params)
      statement.audio_file.save! if statement.save!
      statement
    end

    def audio_file_params
      {
        file_link: params[:audio_file][:file_link],
        duration_seconds: params[:audio_file][:duration_seconds]
      }
    end

    def created_json(comment)
      {
        comment: comment, statement: comment.sender,
        audio_file: comment.sender.audio_file, message: SUCCESS_CREATE_MESSAGE
      }.to_json
    end

    def comment_from_current_user
      Comment.find_by(sender: sender, recipient: recipient)
    end

    def sender
      statement_id = Comment.find(params[:id]).sender_id
      current_user.statements.find(statement_id)
    end

    def forbidden
      head :forbidden
    end
  end
end
