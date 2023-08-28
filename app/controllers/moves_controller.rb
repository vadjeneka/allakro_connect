class MovesController < ApplicationController
  def index 
    if current_user
      @user = current_user
      @moves = Move.all 
    else
      flash[:notice] = "Connexion réquise"
      redirect_to new_user_session_path
    end
  end

  def new 
    @move = Move.new
  end

  def create
    @move = Move.new(move_params)
    if @move.save 
      flash[:success] = "Enregistré réussi"
      redirect_to moves_path
    else
      render :new
    end
  end

  def show 
    @move = Move.find(params[:id])
  end

  private 

  def move_params
    params.require(:move).permit(
      :first_last_name_owner,
      :sexe,
      :function,
      :date_of_birth,
      :new_destination,
      :family_location_place
    )
  end
end
