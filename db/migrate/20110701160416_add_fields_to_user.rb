class AddFieldsToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :full_name, :string
    add_column :users, :first_barcamp, :boolean
    add_column :users, :tshirt_size, :string
  end

  def self.down
    remove_column :users, :tshirt_size
    remove_column :users, :first_barcamp
    remove_column :users, :full_name
  end
end
