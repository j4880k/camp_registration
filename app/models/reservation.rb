include ActionView::Helpers::NumberHelper
class Reservation < ActiveRecord::Base
  belongs_to :person
  # has_one :user, :through => :person
  belongs_to :event
  has_many :reservation_resources
  has_many :resources, :through => :reservation_resources
  accepts_nested_attributes_for :resources,:reservation_resources, :allow_destroy => true
  
  def amount_due
    number_to_currency( self.event.price.to_f + self.amountpaid.to_f + all_discounts.to_f )
  end
  
  def all_discounts
    #in reality discount will be applied at checkout
    number_to_currency( -5.00 )
  end
end
