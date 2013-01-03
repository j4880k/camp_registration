class PaymentNotificationsController < ApplicationController
  protect_from_forgery :except => [:create]
  
  
  def firstdata_success
    puts params.inspect
    redirect_to "/reservation_carts/"
  end
  
  def firstdata_failure
    puts params.inspect
    redirect_to "/reservation_carts/"
  end
  
  # invoice_fields:
  # id
  # user_id
  # reference_code
  # items_hash
  # payment_type
  # payment_date
  # is_confirmed
  # broker_stream
  # status
  # created_at
  # updated_at
  # user_coupon_code
  #nifty_scaffold payment_notification params:text reference_code:string invoice_id:integer payment_status:string transaction_id:string create  
  #curl -d "txn_id=3XC103945N720211C&invoice=923204115&payment_status=Completed" http://localhost:3000/payment_notifications
  def create
    PaymentNotification.create!(:params => params, :reference_code => params[:invoice], :payment_status => params[:payment_status], :transaction_id => params[:txn_id])
      render :nothing => true    
    
    # @payment_notification = PaymentNotification.new(params[:payment_notification])
    # if @payment_notification.save
    #   redirect_to root_url, :notice => "Successfully created payment notification."
    # else
    #   render :action => 'new'
    # end
    puts params.inspect
    # redirect_to "/reservation_carts/"
  end
end
