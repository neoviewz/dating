class AddFieldsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :username, :string
    add_index :users, :username, unique: true
    add_column :users, :city, :string
    add_column :users, :latitude, :float
    add_column :users, :longitude, :float
    add_column :users, :couple_type, :string
  end
end
