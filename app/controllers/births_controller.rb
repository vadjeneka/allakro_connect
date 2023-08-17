class BirthsController < ApplicationController
  def index 
    if current_user
      @births = Birth.all
    else
      flash[:notice] = "Connexion réquise"
      redirect_to new_user_session_path
    end
  end

  def show 
    
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
