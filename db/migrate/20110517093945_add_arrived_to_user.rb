class AddArrivedToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :arrived, :boolean
  end

  def self.down
    remove_column :users, :arrived
  end
end
