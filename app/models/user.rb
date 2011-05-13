class User < ActiveRecord::Base
  default_scope order('updated_at DESC')
  scope :maybe, where(:status => 2)
  scope :yes, where(:status => 1)
  scope :no, where(:status => 0)
  
  def self.create_with_omniauth(auth)
    logger.debug auth
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["user_info"]["name"]
      user.image = auth['user_info']['image']
      user.url = case auth["provider"]
        when 'facebook'
          auth['user_info']['urls']['Facebook']
        when 'twitter'
          "https://twitter.com/#{auth['user_info']['nickname']}"
        end
    end
  end
end
