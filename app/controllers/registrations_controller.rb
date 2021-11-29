# app/controllers/registrations_controller.rb
class RegistrationsController < Devise::RegistrationsController

  protected

  

  def update_resource(resource, user_params)
    #raise resource.inspect
    #raise user_params.inspect
    #raise params[:user].inspect
    #raise resource.first_name.inspect 
    resource.first_name = params[:user][:first_name]
    resource.last_name = params[:user][:last_name]
    resource.email = params[:user][:email]
    resource.city = params[:user][:city]
    resource.phone = params[:user][:phone]
    resource.town = params[:user][:town]
    resource.save
  end
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :phone, :city, :town)
  end
end



