require 'uri'

class User < ActiveRecord::Base
  has_many :tokens
  devise :database_authenticatable, :registerable, :confirmable, :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  attr_accessible :comment, :position, :company, :company_url, :full_name, :first_barcamp, :tshirt_size, :status, :email, :password, :password_confirmation, :remember_me
  default_scope order('created_at DESC')
  scope :maybe, where(:status => 2)
  scope :yes, where(:status => 1)
  scope :no, where(:status => 0)
  validates_presence_of :tshirt_size, :on => :update
  validates_inclusion_of :tshirt_size, :in => %w(WXS WS WM WL WXL XS S M L XL XXL 3XL 4XL 5XL 6XL), :message => "%{value} is not a valid t-shirt size", :on => :update
  validates_inclusion_of :status, :in => [0,1,2], :message => "%{value} is not a valid participation status", :on => :update
  
  def self.new_with_session(params, session)
    super.tap do |user|
      if auth = session[:omniauth]
        user.apply_omniauth(auth)
        user.tokens.build(:provider => auth['provider'], :uid => auth['uid'], :data => auth['user_info'])
      end
    end
  end

  def apply_omniauth(auth)
    logger.debug "omniauth auth:\n#{auth.inspect}"
    case auth['provider']
    when 'twitter'
      self.full_name = auth['user_info']['name']
      self.image = auth['user_info']['image']
      self.homepage = auth['user_info']['urls']['Website']
    when 'facebook'
      self.full_name = auth['user_info']['name']
      self.image = auth['user_info']['image']
      self.homepage = auth['user_info']['urls']['Website']
      self.email = auth['extra']['user_hash']['email']
    #when 'google_apps'
    end
    #self.password = Devise.friendly_token[0,20]

    tokens.build(:provider => auth['provider'], :uid => auth['uid'], :data => auth['user_info'])
  end
  
  def update_with_password(params={})
    params.delete(:current_password)
    self.update_without_password(params)
  end
  
  after_find :add_full_name
  #before_save :check_company_url
  
  def add_full_name
    self.full_name ||= self.name
  end
  
  def check_company_url
    if (self.company_url =~ URI::DEFAULT_PARSER.regexp[:ABS_URI]).nil?
      if ('http://' + self.company_url =~ URI::DEFAULT_PARSER.regexp[:ABS_URI]).nil?
        self.company_url = 'http://' + self.company_url
      end
    end
  end
end
