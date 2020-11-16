class CreateAppointments < ActiveRecord::Migration[6.0]
  def change
    create_table :appointments do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.integer :dog_id
      t.integer :dog_watcher_id
      t.integer :points_earned

      t.timestamps
    end
  end
end
