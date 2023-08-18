class CensusesController < ApplicationController
  def index
    @censuses = Censu.all
    @birth_count = Birth.where(state: ["validated", "waiting"]).count

  end

  private 

  def params_censu 
    params.require(:censu).permit(
      :title,
      :description
    )
  end
end
