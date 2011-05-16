class AddAmountToSponsors < ActiveRecord::Migration
  def self.up
    add_column :sponsors, :amount, :integer
  end

  def self.down
    remove_column :sponsors, :amount
  end
end
