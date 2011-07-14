class Sponsor < ActiveRecord::Base
  default_scope :order => 'amount DESC, created_at ASC'
end
