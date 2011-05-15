class Sponsor < ActiveRecord::Base
  mount_uploader :image, SponsorLogoUploader
end
