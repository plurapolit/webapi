# frozen_string_literal: true

class PanelsController < ApplicationController
  before_action :set_panel, only: %i[edit update destroy]
  before_action :set_category_collection, only: %i[new edit]

  def index
    @panels = Panel.all
  end

  def new
    @panel = Panel.new
  end

  def edit; end

  def create
    @panel = Panel.new(panel_params)

    if @panel.save
      redirect_to panels_path, notice: 'Panel was successfully created.'
    else
      render :new
    end
  end

  def update
    if @panel.update(panel_params)
      redirect_to panels_path, notice: 'Panel was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @panel.destroy
    redirect_to panels_path, notice: 'Panel was successfully destroyed.'
  end

  private

  def set_panel
    @panel = Panel.find(params[:id])
  end

  def set_category_collection
    @category_collection = Category.all
  end

  def panel_params
    params.require(:panel).permit(:category_id, :title, :short_title, :description, :avatar)
  end
end
