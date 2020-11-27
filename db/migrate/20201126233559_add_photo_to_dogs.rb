class AddPhotoToDogs < ActiveRecord::Migration[6.0]
  def change
    add_column :dogs, :photo, :string
  end
end
