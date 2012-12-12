class ReservationCartsController < ApplicationController
   load_and_authorize_resource
  # GET /reservation_carts
  # GET /reservation_carts.json
  def index
    @reservation_carts = ReservationCart.all

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
