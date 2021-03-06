# frozen_string_literal: true

class PanelsController < ApplicationController
  before_action :set_panel, only: %i[edit update destroy deactivate]

  def index
    @panels = Panel.with_attached_avatar
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

  def deactivate
    if @panel.update(deactivated: true)
      redirect_to panels_path, notice: 'Panel was successfully deactivated.'
    else
      redirect_to panels_path, alert: @panel.errors
    end
  end

  private

  def set_panel
    @panel = Panel.find(params[:id])
  end

  def panel_params
    params.require(:panel).permit(:category_id, :title, :short_title, :font_color, :description, :avatar, :is_battle)
  end
end
