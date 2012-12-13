class Invoice < ActiveRecord::Base
  belongs_to :user
  has_many :reservation_carts
  
  def total_balance
    #helper for the link in the cart view
    # @invoice_items=ReservationCart.where(:reference_code => :refcode)
    @total_price=0
    @total_discount=0
    self.reservation_carts.each do |ii|
      #if the item has a coupon code then check it for validity and figure out its discount amount
      # unless ii.coupon_id.nil?
        #do coupon stuff here when it's implemented
        @total_discount += 5
      # end
      @total_price = @total_price + ii.reservation.event.price
    end
    @total_price - @total_discount
  end  
end
