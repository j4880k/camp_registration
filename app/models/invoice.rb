class Invoice < ActiveRecord::Base
  belongs_to :user
  has_many :reservation_carts
  
  def discount_total
    #get all the items that match this coupon
    @discount_amount = 0.00
    unless self.user_coupon_code.nil?
      puts "we will apply discount for #{self.user_coupon_code} "
      coupon_collection = Coupon.where( "code = ?", self.user_coupon_code)
      unless coupon_collection.empty?
        coupon_object=coupon_collection.first
        puts "we have a coupon : #{coupon_object.code}"
        if ((coupon_object.use_limit.to_i<1) or (coupon_object.use_limit.to_i>0 and coupon_object.has_remaining?)) and (coupon_object.is_valid_today?)
          @num_remaining=coupon_object.number_remaining
          
            if coupon_object.event_restricted?
              self.reservation_carts.joins(:reservation => :event).where( :events => {:id => coupon_object.event_id}).each do |ci|
                
                if @num_remaining > 0
                  puts "applying an event restricted coupon to a reservation : #{ci.reservation.event.eventname}"
                  if coupon_object.discount_type=='FIXED'
                    @discount_amount += coupon_object.discount_value
                  else
                    @discount_amount += (ci.reservation.event.price*(coupon_object.discount_value/100).round(2))
                  end
                  @num_remaining=@num_remaining-1
                end
              
              end
            else
              self.reservation_carts.each do |ci|
                
                if @num_remaining > 0
                  puts "applying a coupon to a reservation : #{ci.reservation.event.eventname}"
                  if coupon_object.discount_type=='FIXED'
                    @discount_amount += coupon_object.discount_value
                  else
                    @discount_amount += (ci.reservation.event.price*(coupon_object.discount_value/100).round(2))
                  end
                  @num_remaining=@num_remaining-1
                end
                
              end
            end

        end
      end
    end
    puts "applying a discount amount : #{@discount_amount}"
    @discount_amount
  end
  
  def total_balance
    @total_price=0
    @total_discount=0
    self.reservation_carts.each do |ii|
      @total_price = @total_price + ii.reservation.event.price
    end
    @total_price - discount_total #@total_discount
  end  
end
