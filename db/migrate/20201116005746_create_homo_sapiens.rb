class CreateHomoSapiens < ActiveRecord::Migration[6.0]
  def change
    create_table :homo_sapiens do |t|
      t.string :email
      t.string :password_digest
      t.string :username
      t.integer :net_points
      t.integer :dogs_count
      t.integer :appointments_count

      t.timestamps
    end
  end
end
