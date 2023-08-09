class BirthsController < ApplicationController
  def index 
    @births = Birth.all
  end

  private 

  def params_birth
    params.require(:birth).permit(
      :date,
      :first_name,
      :last_name,
      :sexe,
      :father_name,
      :mother_name,
      :location,
      :valid,
      :birth_mode)
  end
end
