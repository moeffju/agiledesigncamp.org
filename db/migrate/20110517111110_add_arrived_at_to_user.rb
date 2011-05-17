class AddArrivedAtToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :arrived_at, :timestamp
  end

  def self.down
    remove_column :users, :arrived_at
  end
end
