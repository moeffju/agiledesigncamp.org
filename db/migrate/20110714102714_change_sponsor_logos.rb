class ChangeSponsorLogos < ActiveRecord::Migration
  def self.up
    add_column :sponsors, :image_url, :text
    Sponsor.scoped.each do |s|
      s.image_url = s.image.url
      s.save(:validate => false)
    end
  end

  def self.down
    remove_column :sponsors, :image_url
  end
end
