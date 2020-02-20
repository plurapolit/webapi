# frozen_string_literal: true

module Api
  class CommentsController < ApplicationController
    respond_to :json

    SUCCESS_CREATE_MESSAGE = 'Danke für deine Einsendung! Wir werden dein Kommentar in den nächsten Stunden überprüfen.'
    SUCCESS_DELETE_MESSAGE = 'Dein Kommentar wurde erfolgreich gelöscht.'
    SECOND_ARRAY_POSITION = 1

    def index
      @statement = Statement.find(params[:statement_id])
      @comments = sorted_and_accepted_comments(@statement)
      if @comments.any?
        @like_count_of_most_liked_comment = like_count_of_most_liked_comment(@comments.first)
        render :index, status: :ok
      else
        head :no_content
      end
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

    def sorted_and_accepted_comments(statement)
      comments = Comment.of_statement(statement).sort_by { |comment| comment.sender.likes.count }.reverse
      return sorted_comments_with_expert_on_second_position(comments) if array_has_experts?(comments)

      comments
    end

    def array_has_experts?(comments)
      comments.any?(&expert_in_array) && comments.length > 1
    end

    def expert_array_index(comments)
      comments.find_index(&expert_in_array)
    end

    def expert_in_array
      ->(comment) { comment.sender.user.expert? }
    end

    def sorted_comments_with_expert_on_second_position(comments)
      comments.insert(SECOND_ARRAY_POSITION, comments.delete_at(expert_array_index(comments)))
    end

    def like_count_of_most_liked_comment(first_comment)
      like_count = first_comment.sender.likes.count
      return nil if like_count.zero?

      like_count
    end
  end
end
