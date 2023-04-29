class TrendsController < ApplicationController
  def index
    @google_trends = Trend.order(created_at: :desc)
  end
end
