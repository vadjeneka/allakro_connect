class ServicesController < ApplicationController

  def index
    if current_user 
      @user = current_user
      @services = Service.all 
    else
      flash[:notice] = "Connexion réquise"
      redirect_to services_path
    end
  end

  def new 
    @service = Service.new
  end

  def create 
    @service = Service.new(service_params)
    if @service.save 
      flash[:success] = "Offre de service crée"
      redirect_to services_path
    else
      flash[:error] = "Offre non crée"
      render :new
    end
  end

  def show 
    @service = Service.find(params[:id])
  end

  def validate_service 
    @service = Service.find(params[:id])
    @service.update(state: "validated")
    flash[:success] = "Service validé"
    redirect_to services_path
  end

  def reject_service 
    @service = Service.find(params[:id])
    @service.update(state: "cancelled")
    flash[:success] = "Service rjeté"
    redirect_to services_path
  end

  private 

  def service_params
    params.require(:service).permit(
      :first_last_name_owner,
      :service_name,
      :skill,
      :phone_number,
      :message,
      :photo
    )
  end
end
