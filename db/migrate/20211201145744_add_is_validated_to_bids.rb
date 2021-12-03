class AddIsValidatedToBids < ActiveRecord::Migration[6.1]
  def change
    add_column :bids, :validated, :boolean, default: false
  end
end
