class User < ActiveRecord::Base
  default_scope order('updated_at DESC')
  scope :maybe, where(:status => 2)
  scope :yes, where(:status => 1)
  scope :no, where(:status => 0)
  attr_accessible :comment, :position, :company, :company_url, :full_name, :first_barcamp, :tshirt_size, :status
  validates_presence_of :tshirt_size
  validates_inclusion_of :tshirt_size, :in => %w(WXS WS WM WL WXL XS S M L XL XXL 3XL 4XL 5XL 6XL), :message => "%{value} is not a valid t-shirt size"
  validates_inclusion_of :status, :in => [0,1,2], :message => "%{value} is not a valid participation status"
  
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
