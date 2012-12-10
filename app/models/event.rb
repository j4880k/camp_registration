class Event < ActiveRecord::Base
  has_many :event_resources
  has_many :resources, :through => :event_resources
  has_many :reservations
end
