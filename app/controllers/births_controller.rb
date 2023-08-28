class BirthsController < ApplicationController
  def index 
    if current_user
      @user = current_user
      @births = Birth.all
    else
      flash[:notice] = "Connexion réquise"
      redirect_to new_user_session_path
    end
  end

  def new 
    @birth = Birth.new
  end

  def create
    @birth = Birth.new(birth_params)
    if @birth.save
      flash[:success] = "Naissance enregistrée"
      redirect_to births_path
    else
      render :new
    end
  end

  def validate_birth
    @birth = Birth.find(params[:id])
    @birth.update(state: "validated")
    flash[:success] = "Naissance validée"
    redirect_to births_path
  end

  def reject_birth
    @birth = Birth.find(params[:id])
    @birth.update(state: "cancelled")
    flash[:notice] = "Naissance rejetée"
    redirect_to births_path
  end

  def show 
    
  end

  private 

  def birth_params
    params.require(:birth).permit(
      :date,
      :first_name,
      :last_name,
      :sexe,
      :father_name,
      :mother_name,
      :location,
      :state,
      :birth_mode)
  end
end
