class TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_account

  def new 
    @transaction = current_user.account.transactions.build
    @transactions = current_user.account.transactions.all
  end

  def create
    @transaction = current_user.account.transactions.build(transaction_params)
    if @transaction.save
      if @transaction.type_transaction == 'Dépôt'
        if transaction_params[:amount].to_i <= 0
          redirect_to new_user_account_transaction_path(current_user, current_user.account), alert: 'Montant incorrect'
        else
          balance = current_user.account.balance.to_i + transaction_params[:amount].to_i
          if current_user.account.update(balance: balance) 
            redirect_to user_account_path(current_user, current_user.account), notice:'Dépôt effectué avec succès'
          else
            raise current_user.account.errors.inspect
          end
        end
      else
        @transaction.type_transaction =='Rétrait'
          balance = current_user.account.balance.to_i
          if balance >= transaction_params[:amount].to_i && transaction_params[:amount].to_i > 0
            balance = current_user.account.balance.to_i - transaction_params[:amount].to_i
            if current_user.account.update(balance: balance)
              redirect_to user_account_path(current_user, current_user.account), notice:'Rétrait effectué avec succès'
            end
          else
            redirect_to new_user_account_transaction_path(current_user, current_user.account), alert: 'Retrait impossible, solde insuffisant'
          end
        end
      end
  end

  private
  def transaction_params
    params.require(:transaction).permit(:type_transaction, :amount)
  end
  def set_account
    @account = Account.find(params[:account_id])
  end
end
