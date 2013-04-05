class ReservationsController < ApplicationController
  load_and_authorize_resource
  
  def mark_as_removed
    rem_msg = ""
    @existing_instance = ReservationCart.find_by_reservation_id(params[:id])
    if @existing_instance.nil?
      @reservation.is_deleted=true
      if @reservation.save 
        rem_msg = "Reservation #{@reservation.person.fullname} - #{@reservation.event.eventname} has been removed from the list."
      end
      
    else
        rem_msg = "Reservation #{@reservation.person.fullname} - #{@reservation.event.eventname} can not be removed"  
    end

    # render json: cart
    redirect_to '/reservations/', notice: rem_msg 
  end
  
  def add_to_cart
    # Awesomesauce in the reservation view
    #   link_to_remote "Add to cart",
    #   :url => add_to_cart_url(reservation),
    #   :update => { :success => "cart", :failure => "error" }  
    # ReservationCart
    #   :reservation_id (link back to everything important)
    #   :status (new or paid)
    #   :reference_code (all cart items paid at one time will get this value, it's what we send the clearinghouse as a reference id)
    #     *schema will be <random(2).to_upper><user_id>-<yy><mm><dd>-<random(2).to_upper>-<hh><mm><nn>
    #   :invoice_id (the invoice it all translates into... this is what they will print) ;)   
    puts params
    puts @reservation.inspect
    @existing_instance = ReservationCart.find_by_reservation_id(params[:id])
    if @existing_instance.nil?
      cart = ReservationCart.new
      cart.reservation_id = params[:id]
      cart.status = "new" 
      cart.save  
    end  
    # render json: cart
    redirect_to '/reservation_carts/'
    
  end
   
  # GET /reservations
  # GET /reservations.json
  def index
    # @reservations = Reservation.joins(:person => :reservations).where(:people => {:user_id => current_user.id})
      @reservations = Reservation.joins(:person).where(:people => {:user_id => current_user.id})
    if current_user.role? :admin 
      @reservations = Reservation.all
    end   
    
    # @reservations = Reservation.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reservations }
    end
  end

  # GET /people
  # GET /people.json  
  # def get_reservations
  #   @reservations = current_user.reservations #start out minimal context
  #   if current_user.admin 
  #     @reservations = Reservation.all
  #   end
  #   # if current_user.role? director
  #   respond_to do |format|
  #     format.html # index.html.erb
  #     format.json { render :json => @reservations }
  #   end    
  # end

  # GET /reservations/1
  # GET /reservations/1.json
  def show
    # @reservation = Reservation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @reservation }
    end
  end

  # GET /reservations/new
  # GET /reservations/new.json
  def new
    @reservation = Reservation.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @reservation }
    end
  end

  # GET /reservations/1/edit
  def edit
    # @reservation = Reservation.find(params[:id])
  end

  # POST /reservations
  # POST /reservations.json
  def create
    # @reservation = Reservation.new(params[:reservation])
    #Client.where("orders_count = ? AND locked = ?", params[:orders], false)
    if @reservation.person.reservations.where("event_id = ? AND is_deleted = ?" , @reservation.event_id , false ).count > 0
    # if @reservation.person.reservations.where(:event_id => @reservation.event_id).count > 0
      @reservation.errors.add(:base, "A #{@reservation.event.event_with_dates} reservation already exists for #{@reservation.person.fullname}" )
      respond_to do |format|
          format.html { render action: "new" }
          format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end      
    else
      respond_to do |format|
        if @reservation.save
          format.html { redirect_to @reservation, notice: 'Reservation was successfully created.' }
          format.json { render json: @reservation, status: :created, location: @reservation }
        else
          format.html { render action: "new" }
          format.json { render json: @reservation.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PUT /reservations/1
  # PUT /reservations/1.json
  def update
    # @reservation = Reservation.find(params[:id])

    respond_to do |format|
      if @reservation.update_attributes(params[:reservation])
        format.html { redirect_to @reservation, notice: 'Reservation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservations/1
  # DELETE /reservations/1.json
  def destroy
    # @reservation = Reservation.find(params[:id])
    @reservation.destroy

    respond_to do |format|
      format.html { redirect_to reservations_url }
      format.json { head :no_content }
    end
  end
end
