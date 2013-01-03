class Invoice < ActiveRecord::Base
  belongs_to :user
  has_many :reservation_carts

  #   def firstdata_url(return_url, notify_url)
  #     values = {
  #       :business => 'seller_1229899173_biz@railscasts.com',
  #       :cmd => '_cart',
  #       :upload => 1,
  #       :return => return_url,
  #       :invoice => id,
  #       :notify_url => notify_url
  #     }
  #     line_items.each_with_index do |item, index|
  #       values.merge!({
  #         "amount_#{index+1}" => item.unit_price,
  #         "item_name_#{index+1}" => item.product.name,
  #         "item_number_#{index+1}" => item.id,
  #         "quantity_#{index+1}" => item.quantity
  #       })
  #     end
  #     "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
  #   end
  
  # https://www.staging.linkpointcentral.com/lpc/servlet/lppay
  # https://www.linkPointcentral.com/lpc/servlet/lppay
  #LinkPoint hosted form URL:
  # https://www.linkPointcentral.com/lpc/servlet/lppay
  # storename: your LinkPoint account number
  # chargetotal: total amount to be billed. The provided checkout configurations retrieve this value from the GrandTotal value in your eCart implementation.
  # mode: identifies the processing mode for the configuration. The Basic configuration specifies fullpay, which has the LinkPoint form collect all transaction information other that the basic info passed from the checkout form. The Complete and Recurring configurations use payplus, which allows you to pass all transaction information accepted by the gateway. Please read the documentation of all available mode types and their corresponding variables to determine what information you want to pass to LinkPoint specific to your transaction.
  # txntype: sets the type of transaction being passed to the merchant gateway. All configurations have a default of sale, the type necessary to complete a payment transaction.
  # description: passes descriptive text for the transaction. Pre-configured to send the FullDetails string available from the eCart object which provides the name, price and quantity of the items passed from the shopping cart.
  
  # function os_firstdata($params) {
  #   parent::setName('os_firstdata');
  #   parent::os_payment();           
  #   parent::setCreditCard(false);   
  #       parent::setCardType(false);
  #       parent::setCardCvv(false);
  #       parent::setCardHolderName(false);
  #   if ($params->get('firstdata_mode'))
  #     $this->_url = 'https://connect.firstdataglobalgateway.com/IPGConnect/gateway/processing';
  #   else      
  #     $this->_url = 'https://connect.merchanttest.firstdataglobalgateway.com/IPGConnect/gateway/processing';
  #   $this->shared_secret = $params->get('shared_secret');     
  #   $this->setParam('storename', $params->get('store_number'));
  #   $this->setParam('mode', 'payonly');
  #   $this->setParam('txntype', 'sale');
  #   $this->setParam('txndatetime', date("Y:m:d-H:i:s")) ;
  #   $this->setParam('timezone', 'EST') ;    
  # }  
  
  
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
