# frozen_string_literal: true

class StatementsController < ApplicationController
  before_action :set_statement, only: %i[edit update destroy]

  def index
    @statements = Statement.all.includes(%i[panel user audio_file])
  end

  def new
    @statement = Statement.new
  end

  def edit; end

  def create
    @statement = Statement.new(statement_params)

    if @statement.save
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

  private

  def set_statement
    @statement = Statement.find(params[:id])
  end

  def statement_params
    params.require(:statement).permit(:panel_id, :audio_file_id, :user_id, :quote, :status)
  end
end
