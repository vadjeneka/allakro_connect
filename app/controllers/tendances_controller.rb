class TendancesController < ApplicationController
  def index
    @tendances = Tendance.order(created_at: :desc).take(20)
  end
end
