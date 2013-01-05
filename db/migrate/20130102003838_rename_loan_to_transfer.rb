class RenameLoanToTransfer < ActiveRecord::Migration
  def up
  	rename_table :loans, :transfers
  end

  def down
  	rename_table :transfers, :loans
  end
end
