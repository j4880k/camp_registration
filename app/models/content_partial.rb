class ContentPartial < ActiveRecord::Base
  belongs_to :user
  
  def is_usable?
    self.is_active
  end  

  
end
