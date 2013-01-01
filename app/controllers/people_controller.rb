class PeopleController < ApplicationController
  load_and_authorize_resource
  # GET /people
  # GET /people.json
  def index
    @people = Person.where( :user_id => current_user.id)
    if current_user.role? :admin 
      @people = Person.all
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @people }
    end
  end

  # GET /people
  # GET /people.json  
  # def get_people
  #   @people = Person.select( :current_user.people #start out minimal context
  #   if current_user.admin 
  #     @people = Person.all
  #   end
  #   # if current_user.role? director
  #   respond_to do |format|
  #     format.html # index.html.erb
  #     format.json { render :json => @people }
  #   end    
  # end
  
  # GET /people/1
  # GET /people/1.json
  def show
    # @person = Person.find(params[:id])
    @person.pct_complete = @person.requirement_progress
    @person.save
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @person }
    end
  end

  # GET /people/new
  # GET /people/new.json
  def new
    # @person = Person.new
    1.times do
      address = @person.addresses.build
    end
    1.times do
      email = @person.emails.build
    end
    1.times do
      organization = @person.organizations.build
    end
    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @person }
    end
  end

  # GET /people/1/edit
  def edit
    # @person = Person.find(params[:id])
  end

  # POST /people
  # POST /people.json
  def create
    # @person = Person.new(params[:person])
    @person = Person.create(params[:person].merge(:user => current_user))
    # @person.pct_complete = @person.requirement_progress
    respond_to do |format|
      if @person.save
        format.html { redirect_to @person, :notice => 'Person was successfully created.' }
        format.json { render :json => @person, :status => :created, :location => @person }
      else
        format.html { render :action => "new" }
        format.json { render :json => @person.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /people/1
  # PUT /people/1.json
  def update
    # @person = Person.find(params[:id])
    # @person.pct_complete = @person.requirement_progress
    respond_to do |format|
      if @person.update_attributes(params[:person])
        format.html { redirect_to @person, :notice => 'Person was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @person.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1
  # DELETE /people/1.json
  def destroy
    # @person = Person.find(params[:id])
    @person.destroy

    respond_to do |format|
      format.html { redirect_to people_url }
      format.json { head :no_content }
    end
  end
end
