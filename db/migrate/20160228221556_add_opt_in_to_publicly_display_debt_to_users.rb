class AddOptInToPubliclyDisplayDebtToUsers < ActiveRecord::Migration
  def change
    add_column :users, :opt_to_share_debt, :boolean
  end
end
