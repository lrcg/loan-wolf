class AddCreditorUserIdToLoan < ActiveRecord::Migration
  def change
    add_column :loans, :creditor_user_id, :integer
  end
end
