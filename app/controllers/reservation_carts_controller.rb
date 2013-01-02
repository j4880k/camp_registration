class ReservationCartsController < ApplicationController
   load_and_authorize_resource
   
   def generate_id(len = 15)
     s = ''
     len.times { s << 97 + rand(26) }
     s.freeze
   end
   def proceed_to_checkout
         @reservation_carts = ReservationCart.joins(:reservation => {:person => :user}).where(:users => {:id => current_user.id}, :status => 'new')
         #create the invoice
         #reference_code : schema will be <random(2).to_upper><user_id>-<yy><mm><dd>-<random(2).to_upper>-<hh><mm><nn>
         #"#{generate_id(2).upcase}<small portion of sessionid>-#{Time.now.strftime("%y%m%d")}-#{generate_id(2).upcase}-#{Time.now.strftime("%H%M%S")}"
         # invoices (this is created at checkout) - I'm thinking this is where the clearinghouse information gets stored.
         #  :user_id
         #  :reference_code
         #  :items_hash
         #  :payment_type
         #  :payment_date
         #  :is_confirmed
         #  :broker_stream
         #  :status
         # 
         #  => when a person clicks "proceed to checkout" it will create a new invoice. This invoice is a black hole until the transaction is successful.
         #  => on the invoice the person can:
         #    * enter coupons
         #    * enter credit card information
         #    * initiate payment
         #    => status: new, processing, failed, success <- completely system controlled
         unless @reservation_carts.nil?

           #since session_id might not always be there (edge cases) we'll cover ourselves
           sessid = session['session_id']
           if (sessid.nil?) or (sessid=="")
             session_snip = "!#{generate_id(2)}"
           else
             session_snip = session['session_id'].slice(5,2)
           end
           
           refcode = "#{generate_id(2).upcase}#{session_snip.upcase}-#{Time.now.strftime("%y%m%d")}-#{generate_id(2).upcase}-#{Time.now.strftime("%H%M%S")}"
           @inv = Invoice.new( :user_id => current_user.id, :reference_code => refcode, :status => 'new')
           @inv.save
           puts "reservation_carts.size is #{@reservation_carts.size}"
           
           #mark the shopping cart items
           @reservation_carts.each do |rc|
             puts "attempting to update reservation_cart:#{rc.id} ownedby: #{rc.reservation.person.user.email} by #{current_user.email}"
             wc = ReservationCart.find_by_id(rc.id)
             wc.reference_code = refcode
             wc.status = 'processing'
             wc.invoice_id = @inv.id
             wc.save
           end
           
           redirect_to "/invoices/#{@inv.id}"
         end
   end
   
  # GET /reservation_carts
  # GET /reservation_carts.json
  def index
    @reservation_carts = ReservationCart.joins(:reservation => {:person => :user}).where(:users => {:id => current_user.id}, :status=>'new')
    if current_user.role? :admin 
      @reservation_carts = ReservationCart.all
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reservation_carts }
    end
  end

  # GET /reservation_carts/1
  # GET /reservation_carts/1.json
  def show
    # @reservation_cart = ReservationCart.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @reservation_cart }
    end
  end

  # GET /reservation_carts/new
  # GET /reservation_carts/new.json
  def new
    # @reservation_cart = ReservationCart.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @reservation_cart }
    end
  end

  # GET /reservation_carts/1/edit
  def edit
    # @reservation_cart = ReservationCart.find(params[:id])
  end

  # POST /reservation_carts
  # POST /reservation_carts.json
  def create
    @reservation_cart = ReservationCart.new(params[:reservation_cart])

    respond_to do |format|
      if @reservation_cart.save
        format.html { redirect_to @reservation_cart, notice: 'Reservation cart was successfully created.' }
        format.json { render json: @reservation_cart, status: :created, location: @reservation_cart }
      else
        format.html { render action: "new" }
        format.json { render json: @reservation_cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /reservation_carts/1
  # PUT /reservation_carts/1.json
  def update
    # @reservation_cart = ReservationCart.find(params[:id])

    respond_to do |format|
      if @reservation_cart.update_attributes(params[:reservation_cart])
        format.html { redirect_to @reservation_cart, notice: 'Reservation cart was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @reservation_cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservation_carts/1
  # DELETE /reservation_carts/1.json
  def destroy
    # @reservation_cart = ReservationCart.find(params[:id])
    @reservation_cart.destroy

    respond_to do |format|
      format.html { redirect_to reservation_carts_url }
      format.json { head :no_content }
    end
  end
end
