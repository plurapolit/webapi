# frozen_string_literal: true

class OrganisationsController < ApplicationController
  before_action :set_organisation, only: %i[edit update destroy]

  def index
    @organisations = Organisation.all.includes([:avatar_attachment])
  end

  def new
    @organisation = Organisation.new
  end

  def edit; end

  def create
    @organisation = Organisation.new(organisation_params)

    if @organisation.save
      redirect_to organisations_path, notice: 'Organisation was successfully created.'
    else
      render :new
    end
  end

  def update
    if @organisation.update(organisation_params)
      redirect_to organisations_path, notice: 'Organisation was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @organisation.destroy
    redirect_to organisations_path, notice: 'Organisation was successfully destroyed.'
  end

  private

  def set_organisation
    @organisation = Organisation.find(params[:id])
  end

  def organisation_params
    params.require(:organisation).permit(:name, :description, :avatar)
  end
end
