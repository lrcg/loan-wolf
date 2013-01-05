class CreateEventLogs < ActiveRecord::Migration
  def change
    create_table :event_logs do |t|
      t.string :event_type
      t.string :primary_model
      t.integer :primary_model_id
      t.string :serialized_data
      t.string :hr_summary

      t.timestamps
    end
  end
end
