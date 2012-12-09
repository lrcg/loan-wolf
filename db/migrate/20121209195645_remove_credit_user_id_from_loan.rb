class RemoveCreditUserIdFromLoan < ActiveRecord::Migration
  def up
  	remove_column :loans, :credit_user_id
  end

  def down
  	add_column :loans, :credit_user_id, :integer
  end
end
