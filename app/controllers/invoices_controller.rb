class InvoicesController < ApplicationController
  load_and_authorize_resource
  
  def finalize_zero_balance_transaction
    if @invoice.status=='new' and (@invoice.total_balance<=0)
      ##let's just make a new payment notification for it!!
      @tdt = "#{DateTime.now.strftime('%Y:%m:%d-%H:%M:%S')}"
    	@tdround = "#{(sprintf('%.2f', 0.00))}"
    	@pieces = "INTERNALSTORE-#{@tdt}#{@tdround}-NOSECRETID"
    	@hash = "nohash-internally-resoved"
    	@invoice_items = @invoice.reservation_carts
      @fd_params = {"storename"=> "INTERNALSTORE",
    	"mode"=>"payonly",
    	"txntype"=>"sale",
    	"timezone"=>"EST",
    	"txndatetime" => "#{@tdt}",
    	"hash" => "#{@hash}", 
    	"chargetotal"=> "#{@tdround}",
    	"subtotal"=> "#{@tdround}",
    	"responseURL"=> "SELF-SERV", # "#{url_for(:controller => :payment_notifications, :only_path => false)}",
    	"oid"=>"#{@invoice.reference_code}",
    	"trxOrigin" => "ECI",
    	"email"=>"#{@invoice.user.email}",
    	# "userid" => "#{current_user.email}",
    	"userid" => "#{@invoice.reference_code}",
    	"shared_secret" => "NOSECRETID",
    	"reference" => "Camp Registration",
    	"comments" => @invoice_items,
    	"responseSuccessURL" => "SELF-SERV",  # "#{root_url}",
    	"responseFailURL" => "SELF-SERV",
    	"status" => "APPROVED"
    	} # "#{root_url}",
    	@trans_id_parts = ["Y","APPROVED-ZERO-BALANCE"]

      @trans_id_code = "#{@trans_id_parts[1]}-#{params[:txndatetime]}"

      @is_approved = @trans_id_parts[0]=="Y" ? true : false
      
    	@pn = PaymentNotification.new(:params => @fd_params, :reference_code => @fd_params["oid"], :payment_status => @fd_params["status"], :transaction_id => @trans_id_code, :env_headers => "" )
    	@pn.save
    	
    	@pn.synchronize_with_system
      @invoice.commit_invoice_prices    	
      # redirect_to "/reservation_carts/"
    end  
  end 
  
  def cancel_invoice
    if @invoice.status=='new'
      @invoice.reservation_carts.each do |cart|
        cart.reservation.billing_status='cancelled'
        cart.reservation.save
        cart.destroy
      end
        @invoice.destroy
    end
    redirect_to "/reservation_carts/"
  end
  
  def items_matching_coupon
    @invoice.reservation_carts.joins(:reservation => :event).where( :events => {:id => @coupon.event_id})
  end
  
  def invoice_has_items_for_coupon?
     items_matching_coupon.count > 0
  end
  
  def calculate_coupon_and_save(params)
    # params = @params
  
  end

  def submit_transaction_to_firstdata
    #we're going to just set the line totals on our carts
    @invoice.commit_invoice_prices
  end
  
  def apply_coupon_code
    note="Error: You did not enter a coupon code"
    # @params = params
    unless params[:user_coupon_code].nil?
      is_valid = false
      @coupon=Coupon.find_by_code(params[:user_coupon_code].upcase)
      notice_text = @invoice.user_coupon_code.blank? ? note : "There was a problem retrieving your coupon. #{params[:user_coupon_code]} does not appear to be valid at this time."
      unless @coupon.nil?
        coupon_tag = @coupon.code_mask ? "**SPECIAL DISCOUNT**" : @coupon.code
        notice_text= "Coupon #{params[:user_coupon_code]} has returned a coupon described as '#{@coupon.description_with_dates}' "

        #Is the coupon restricted for certain event?
        if @coupon.usable_coupon?
          if @coupon.event_restricted? && 
            if invoice_has_items_for_coupon?
              notice_text += "You have #{items_matching_coupon.count} reservations in your basket that could use this coupon"
              #we can't use the coupon more times than it's supposed to be used.
              @invoice.user_coupon_code = params[:user_coupon_code].upcase
              # @invoice.save
              is_valid = true
            else
              notice_text += "There are no items in your cart eligible for the coupon"
            end
          else
            @invoice.user_coupon_code = params[:user_coupon_code].upcase
            # @invoice.save
            is_valid = true
            notice_text += "You have #{@invoice.reservation_carts.count} reservations in your basket that this coupon applies to"     
          end
        else
          notice_text += " The coupon code you used is not valid."
        end     
      end 
      notice_text
    end
    unless is_valid
      @invoice.user_coupon_code = ""
    end
    @invoice.save
    redirect_to @invoice, notice: notice_text
  end

  # GET /invoices
  # GET /invoices.json
  def index
    @invoices = Invoice.where( :user_id => current_user.id).all
    if current_user.role? :admin 
      @invoices = Invoice.all
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @invoices }
    end
  end

  # GET /invoices/1
  # GET /invoices/1.json
  def show
    # @invoice = Invoice.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @invoice }
    end
  end

  # GET /invoices/new
  # GET /invoices/new.json
  def new
    # @invoice = Invoice.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @invoice }
    end
  end

  # GET /invoices/1/edit
  def edit
    # @invoice = Invoice.find(params[:id])
  end

  # POST /invoices
  # POST /invoices.json
  def create
    # @invoice = Invoice.new(params[:invoice])

    respond_to do |format|
      if @invoice.save
        format.html { redirect_to @invoice, notice: 'Invoice was successfully created.' }
        format.json { render json: @invoice, status: :created, location: @invoice }
      else
        format.html { render action: "new" }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /invoices/1
  # PUT /invoices/1.json
  def update
    # @invoice = Invoice.find(params[:id])

    respond_to do |format|
      if @invoice.update_attributes(params[:invoice])
        format.html { redirect_to @invoice, notice: 'Invoice was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invoices/1
  # DELETE /invoices/1.json
  def destroy
    # @invoice = Invoice.find(params[:id])
    @invoice.destroy

    respond_to do |format|
      format.html { redirect_to invoices_url }
      format.json { head :no_content }
    end
  end
end
