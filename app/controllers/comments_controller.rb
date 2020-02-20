# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_comment, only: %i[edit update destroy accept reject]

  def index
    @comments = Statement.only_comments.includes(%i[panel user audio_file sent_comment]).order(created_at: :desc)
  end

  def new
    @comment = Statement.new
    @comment.build_audio_file
    @comment.build_sent_comment
  end

  def edit; end

  def create
    @comment = Statement.new(statement_params)
    @comment.build_audio_file(audio_file_params)
    @comment.build_sent_comment(comment_params)
    if @comment.save!
      @comment.audio_file.save!
      @comment.sent_comment.save!
      redirect_to comments_path, notice: 'Comment was successfully created.'
    else
      render :new
    end
  end

  def update
    if @comment.update(statement_params)
      redirect_to comments_path, notice: 'Comment was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    redirect_to comments_path, notice: 'Comment was successfully destroyed.'
  end

  def accept
    @comment.accepted!
    redirect_to comments_path, notice: 'Comment was accepted.'
  end

  def reject
    @comment.rejected!
    redirect_to comments_path, alert: 'Comment was rejected.'
  end

  private

  def set_comment
    @comment = Statement.find(params[:id])
  end

  def statement_params
    params.require(:statement).permit(
      :audio_file_id, :user_id, :quote,
      :status, audio_file: %i[file_link duration_seconds]
    ).merge(panel_id: recipient_panel_id)
  end

  def recipient_panel_id
    Statement.find(params[:recipient_statement][:id]).panel_id
  end

  def audio_file_params
    {
      file_link: params[:audio_file][:file_link],
      duration_seconds: params[:audio_file][:duration_seconds]
    }
  end

  def comment_params
    {
      recipient_id: params[:recipient_statement][:id]
    }
  end
end
