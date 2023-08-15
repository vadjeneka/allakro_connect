class CensusesController < ApplicationController
  def index
    @censuses = Censu.all
  end

  private 

  def params_censu 
    params.require(:censu).permit(
      :title,
      :description
    )
  end
end
