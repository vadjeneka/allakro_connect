class AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_account


  private
  def set_account
    @account = Account.find(params[:id])
  end
end
