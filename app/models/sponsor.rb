class Sponsor < ActiveRecord::Base
  mount_uploader :image, SponsorLogoUploader
  default_scope :order => 'amount DESC, created_at DESC'
end
