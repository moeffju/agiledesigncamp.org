class ConfirmUsers < ActiveRecord::Migration
  def self.up
    User.all.each{ |u| u.confirm! }
  end

  def self.down
  end
end
