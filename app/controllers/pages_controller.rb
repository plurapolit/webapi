# frozen_string_literal: true

class PagesController < ApplicationController
  def healthcheck
    render json: { msg: 'healthy' }, status: :ok
  end

  def home
    @unchecked_statements_count = Statement.pending.count
  end
end
