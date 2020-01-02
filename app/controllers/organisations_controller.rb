# frozen_string_literal: true

class OrganisationsController < ApplicationController
  def show
    @organisation = Organisation.find(params[:id])
    render json: @organisation
  end

  def index
    @organisations = Organisation.all
    render json: @organisations
  end

  def new; end

  def create; end

  def edit; end

  def update; end

  def destroy; end
end
