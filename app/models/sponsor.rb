class Sponsor < ActiveRecord::Base
  default_scope :order => 'amount DESC, created_at ASC'
  
  def level
    case self.amount
    when 0..499; :supporter;
    when 500..799; :silver;
    when 800..1999; :gold;
    when 2000..1000000000; :main;
    end
  end
end
