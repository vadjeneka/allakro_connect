class AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_account

  def show
    @account = Account.find(params[:id])
    @transactions = current_user.account.transactions
  end
  private
  def set_account
    @account = Account.find(params[:id])
  end
end
