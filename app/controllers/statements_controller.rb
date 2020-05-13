# frozen_string_literal: true

class StatementsController < ApplicationController
  before_action :set_statement, only: %i[edit update destroy accept reject create_intro create_transcription]

  def index
    @statements = Statement.without_comments
                           .includes(%i[panel user audio_file intro transcription])
                           .order(created_at: :desc)
  end

  def new
    @statement = Statement.new
    @statement.build_audio_file
  end

  def edit; end

  def create
    @statement = Statement.new(statement_params)
    if @statement.save!
      redirect_to statements_path, notice: 'Statement was successfully created.'
    else
      render :new
    end
  end

  def update
    if @statement.update(statement_params)
      redirect_to statements_path, notice: 'Statement was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @statement.destroy
    redirect_to statements_path, notice: 'Statement was successfully destroyed.'
  end

  def accept
    @statement.accepted!
    redirect_to statements_path, notice: 'Statement was accepted.'
  end

  def reject
    @statement.rejected!
    redirect_to statements_path, alert: 'Statement was rejected.'
  end

  def create_intro
    @statement.create_intro
    redirect_to statements_path, notice: 'Intro for statement was created.'
  end

  def create_transcription
    TranscriptionJob.perform_later(@statement.id)
    redirect_to statements_path, notice: 'Transcription job started.'
  end

  private

  def set_statement
    @statement = Statement.find(params[:id])
  end

  def statement_params
    params.require(:statement).permit(:id, :panel_id, :audio_file_id, :user_id, :quote,
                                      :status, audio_file_attributes: %i[id statement_id file_link duration_seconds])
  end
end
