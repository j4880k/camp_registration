class InvoicesController < ApplicationController
  load_and_authorize_resource
  
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
        
        #Is the coupon for this date?
        # if @coupon.is_valid_today?
        #   notice_text += " The coupon's effective date range makes it valid today."
        # else
        #   notice_text += " The coupon is not currently active."
        # end 
        
        #Is the coupon restricted in uses?
        # if @coupon.has_remaining?
        #    notice_text += " There are coupons still available"
        #  else
        #    notice_text += " There are no more coupons left for this code."
        #  end
        
        #Coupon type appled to amount due
        
      end
      redirect_to @invoice, notice: notice_text
    end
  end

  # GET /invoices
  # GET /invoices.json
  def index
    @invoices = Invoice.where( :user_id => current_user.id).all

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
