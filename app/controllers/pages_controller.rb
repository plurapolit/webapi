# frozen_string_literal: true

class PagesController < ApplicationController
  def healthcheck
    @sample_age_range = AgeRange.last
  end

  def home
    @unchecked_statements_count = Statement.pending.count
  end
end
