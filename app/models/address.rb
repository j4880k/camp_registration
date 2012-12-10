class Address < ActiveRecord::Base
  has_many :person_addresses
  has_many :people, :through => :person_addresses
end
