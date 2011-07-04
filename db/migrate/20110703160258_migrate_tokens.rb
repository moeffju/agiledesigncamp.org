class MigrateTokens < ActiveRecord::Migration
  def self.up
    User.all.each do |user|
      data = {
        'user_info' => {
          'name' => user.name,
          'image' => user.image,
          'urls' => {}
        }
      }
      data['user_info']['urls'][user.provider.capitalize] = user.url
      Token.create!(user: user, provider: user.provider, uid: user.uid, data: data)
    end
  end

  def self.down
  end
end
