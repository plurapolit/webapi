# frozen_string_literal: true

class StatementsController < ApplicationController
  before_action :set_statement, only: %i[edit update destroy accept reject]

  def index
    @statements = Statement.all.includes(%i[panel user audio_file]).reverse
  end

  def new
    @statement = Statement.new
    @statement.build_audio_file
  end

  def edit; end

  def create
    @statement = Statement.new(statement_params)
    @statement.build_audio_file(audio_file_params)
    if @statement.save!
      @statement.audio_file.save!
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

  private

  def set_statement
    @statement = Statement.find(params[:id])
  end

  def statement_params
    params.require(:statement).permit(:panel_id, :audio_file_id, :user_id, :quote,
                                      :status, audio_file: %i[file_link duration_seconds])
  end

  def audio_file_params
    {
      file_link: params[:audio_file][:file_link],
      duration_seconds: params[:audio_file][:duration_seconds]
    }
  end
end
