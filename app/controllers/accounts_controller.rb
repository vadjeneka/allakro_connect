class AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_account
  def index 
  end
  def destroy
  end

  private
  def set_account
    @account = Account.find(params[:id])
  end
end
