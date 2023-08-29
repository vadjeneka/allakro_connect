class DeathsController < ApplicationController
  def index
    if current_user
      @user = current_user
      @deaths = Death.all.order(created_at: :desc)
    else
      flash[:notice] = "Connexion réquise"
      redirect_to new_user_session_path
    end
  end

  def new 
    @death = Death.new
  end

  def create 
    @death = Death.new(death_params)
    if @death.save 
      flash[:success] = "Décès enregistré"
      redirect_to deaths_path
    else
      render :new
    end
  end

  def show 
    @death = Death.find(params[:id])
  end

  def validate_death
    @death = Death.find(params[:id])
    @death.update(state: "validated")
    flash[:success] = "Décès validé"
    redirect_to deaths_path
  end

  def reject_death
    @death = Death.find(params[:id])
    @death.update(state: "cancelled")
    flash[:success] = "Décès rejeté"
    redirect_to deaths_path
  end

  private

  def death_params
    params.require(:death).permit(
      :first_last_name_death,
      :sexe,
      :function,
      :date_of_birth,
      :date_of_death,
      :death_mode,
      :death_mode_description,
      :father_name,
      :mother_name,
      :location,
      :state
    )
  end

end
