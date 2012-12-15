class Address < ActiveRecord::Base
  has_many :person_addresses
  has_many :people, :through => :person_addresses
  
  def scphonenumber=(scphonenumber)
    write_attribute(:scphonenumber, scphonenumber.to_s.gsub(/[^0-9]/, "").to_i)
  end
end
