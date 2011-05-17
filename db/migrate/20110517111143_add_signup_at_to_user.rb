class AddSignupAtToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :signup_at, :timestamp
  end

  def self.down
    remove_column :users, :signup_at
  end
end
