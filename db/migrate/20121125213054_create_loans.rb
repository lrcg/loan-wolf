class CreateLoans < ActiveRecord::Migration
  def change
    create_table :loans do |t|
      t.integer :credit_user_id
      t.integer :debtor_user_id
      t.float :amount
      t.integer :approved_by_user_id
      t.datetime :approved_date
      t.boolean :is_archived

      t.timestamps
    end
  end
end
