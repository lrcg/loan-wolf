class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.string :text
      t.string :attribution

      t.timestamps
    end
  end
end
