class LocationsController < ApplicationController
  def index 
    if current_user
      @user = current_user
      @locations = Location.all 
    else
      flash[:notice] = "Connexion réquise"
      redirect_to new_user_session_path
    end
  end

  def new 
    @location = Location.new
  end

  def create
    @location = Location.new(location_params)
    if @location.save 
      flash[:success] = "Enregistré réussi"
      redirect_to locations_path
    else
      render :new
    end
  end

  def show 
    @location = Location.find(params[:id])
  end

  def update
    @location = Location.find(params[:id])
    @location.update(location_params)
    flash[:success] = "Modification prise en compte"
    redirect_to locations_path
  end

  private

  def location_params
    params.require(:location).permit(
      :first_last_name_owner,
      :sexe,
      :function,
      :date_of_birth,
      :origin_location,
      :location_mode,
      :family_location_place,
      :new_destination,
      :location_type,
      :family_name
    )
  end
end
