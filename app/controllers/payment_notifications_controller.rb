class PaymentNotificationsController < ApplicationController
  protect_from_forgery :except => [:create]
  def new_payment_notification_from_system
    
  end
  
  def firstdata_success
    puts params.inspect
    redirect_to "/reservation_carts/"
  end
  
  def firstdata_failure
    puts params.inspect
    redirect_to "/reservation_carts/"
  end

  # GET /people
  # GET /people.json
  def index
    @payment_notifications = []
    if current_user.role? :admin 
      @payment_notifications = PaymentNotification.all
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @payment_notifications }
    end
  end

  def create
    
    trans_id_parts = params[:approval_code].nil? ? ["N","#{params[:status]}-NO-CODE"] : params[:approval_code].split(':')
    
    trans_id_code = "#{trans_id_parts[1]}-#{params[:tdate]}"
    
    is_approved = trans_id_parts[0]=="Y" ? true : false
    headers=[]
    for header in request.env.select { |key, val| key.match("^HTTP.*")}
      headers << "#{header[0]}  #{header[1]}"
    end
    for header in request.env.select { |key, val| key.match("^REMOTE.*")}
      headers << "#{header[0]}  #{header[1]}"
    end
    for header in request.env.select { |key, val| key.match("^REQUEST.*")}
      headers << "#{header[0]}  #{header[1]}"
    end
    for header in request.env.select { |key, val| key.match("^SERVER.*")}
      headers << "#{header[0]}  #{header[1]}"
    end
    header_string = headers.join("<!!@!!>")
    PaymentNotification.create!(:params => params, :reference_code => params[:oid], :payment_status => params[:status], :transaction_id => trans_id_code, :env_headers => header_string )
    
    if is_approved
      unless current_user.nil? 
        firstdata_success end
    else
       unless current_user.nil? 
         firstdata_failure end
    end
      # render :nothing => true  
    if current_user.nil? 
        redirect_to "/" end      
  end
  
  
end
