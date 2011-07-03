class MigrateTokens < ActiveRecord::Migration
  def self.up
    User.all.each do |user|
      data = {
        name: user.name,
        image: user.image,
        url: user.url
      }
      Token.create!(user: user, provider: user.provider, uid: user.uid, data: data)
    end
  end

  def self.down
  end
end
