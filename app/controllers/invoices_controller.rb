class InvoicesController < ApplicationController
  load_and_authorize_resource
 
  def submit_transaction_to_firstdata
    # require "open-uri"
    # require "net/https"
    # 
    # params = {
    #   "storename" => "#{FD_STORENAME}",
    #   "mode" => "payonly",
    #   "txntype" => "sale",
    #   "chargetotal" => "199",
    #   "oid" => @invoice.reference_code,
    #   "responseURL" => "#{url_for(:controller => :payment_notifications, :only_path => false)}"
    #   
    # }
    # puts "using params #{params.inspect}"
    # # x = Net::HTTP.post_form(URI.parse('https://www.staging.linkpointcentral.com/lpc/servlet/lppay'), params)
    # url = URI.parse('https://www.staging.linkpointcentral.com/lpc/servlet/lppay')
    # req = Net::HTTP::Post.new(url.path)
    # req.form_data = params
    # con = Net::HTTP.new(url.host)
    # con.use_ssl = true
    # res = con.start{|http| http.request(req)}
    # puts res.body
    # x = Net::HTTP.new(URI.parse('https://www.staging.linkpointcentral.com/lpc/servlet/lppay'), params)
    # puts x.body
    # x.submit
    
    # https://www.staging.linkpointcentral.com/lpc/servlet/lpcpay?storename=1909009697&mode=payonly&txntype=sale&chargetotal=199&oid=AMA-2345ggggisnt
    # require 'net/https'
    # require 'open-uri'

    # url = URI.parse('https://MY_URL')
    # req = Net::HTTP::Post.new(url.path)
    # req.form_data = data
    # req.basic_auth url.user, url.password if url.user
    # con = Net::HTTP.new(url.host, url.port)
    # con.use_ssl = true
    # con.start {|http| http.request(req)}    
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
  
  def apply_coupon_code
    note="Error: nothing sent in"
    unless params[:user_coupon_code].nil?
      @coupon=Coupon.find_by_code(params[:user_coupon_code].upcase)
      notice_text = "There was a problem retrieving your coupon. #{params[:user_coupon_code]} does not appear to be valid at this time."
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
              @invoice.save
            else
              notice_text += "There are no items in your cart eligible for the coupon"
            end
          else
            @invoice.user_coupon_code = params[:user_coupon_code].upcase
            @invoice.save
            notice_text += "You have #{@invoice.reservation_carts.count} reservations in your basket that this coupon applies to"     
          end
        else
          notice_text += " The coupon code you used is not valid."
        end
        
      end
      redirect_to @invoice, notice: notice_text
    end
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
