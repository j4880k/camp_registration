class Resource < ActiveRecord::Base
  has_many :reservation_resources
  has_many :reservations, :through => :reservation_resources
end
