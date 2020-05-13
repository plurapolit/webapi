# frozen_string_literal: true

class TranscriptionsController < ApplicationController
  before_action :set_transcription, only: %i[show edit update destroy]

  def show; end

  def new
    @transcription = Transcription.new
  end

  def edit; end

  def create
    @transcription = Transcription.new(transcription_params)

    if @transcription.save
      redirect_to @transcription, notice: 'Transcription was successfully created.'
    else
      render :new
    end
  end

  def update
    if @transcription.update(transcription_params)
      redirect_to @transcription, notice: 'Transcription was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @transcription.destroy
    redirect_to statements_url, notice: 'Transcription was successfully destroyed.'
  end

  private

  def set_transcription
    @transcription = Transcription.find(params[:id])
  end

  def transcription_params
    params.require(:transcription).permit(:status, :content, :job_url, :statement_id, :job_name)
  end
end
