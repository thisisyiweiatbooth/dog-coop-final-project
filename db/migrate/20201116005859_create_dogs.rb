class CreateDogs < ActiveRecord::Migration[6.0]
  def change
    create_table :dogs do |t|
      t.string :name
      t.integer :owner_id
      t.integer :appointments_count

      t.timestamps
    end
  end
end
