# frozen_string_literal: true

class PagesController < ApplicationController
  def healthcheck
    @sample_age_range = AgeRange.last
  end

  def home; end
end
