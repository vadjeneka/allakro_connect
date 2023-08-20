class CensusesController < ApplicationController
  def index
    @censuses = Censu.all
    @birth_count = Birth.where(state: ["validated", "waiting"]).count
    @death_count = Death.where(state: ["validated", "waiting"]).count
    @service_count = Service.where(state: ["validated", "waiting"]).count
    @location_count = Location.all.count
    @move_count = Move.all.count

  end

  private 

  def params_censu 
    params.require(:censu).permit(
      :title,
      :description
    )
  end
end
