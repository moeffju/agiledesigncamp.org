class AddPositionAndCompanyToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :position, :string
    add_column :users, :company, :string
    add_column :users, :company_url, :text
  end

  def self.down
    remove_column :users, :company_url
    remove_column :users, :company
    remove_column :users, :position
  end
end
