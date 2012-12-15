class PersonMedicalNote < ActiveRecord::Base
  belongs_to :person
  belongs_to :user, :foreign_key => "created_by"
  
  def created_by_name
    unless self.created_by.nil?
      usr=User.find(self.created_by)
      usr.email
    end
  end
end
