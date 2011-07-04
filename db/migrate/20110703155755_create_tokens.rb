class CreateTokens < ActiveRecord::Migration
  def self.up
    create_table :tokens do |t|
      t.integer :user_id
      t.string :provider
      t.string :uid
      t.text :data

      t.timestamps
    end
  end

  def self.down
    drop_table :tokens
  end
end
