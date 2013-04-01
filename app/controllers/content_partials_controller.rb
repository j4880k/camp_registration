class ContentPartialsController < ApplicationController
  load_and_authorize_resource
  # GET /content_partials
  # GET /content_partials.json
  def index
    @content_partials = ContentPartial.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @content_partials }
    end
  end

  # GET /content_partials/1
  # GET /content_partials/1.json
  def show
    @content_partial = ContentPartial.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @content_partial }
    end
  end

  # GET /content_partials/new
  # GET /content_partials/new.json
  def new
    @content_partial = ContentPartial.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @content_partial }
    end
  end

  # GET /content_partials/1/edit
  def edit
    @content_partial = ContentPartial.find(params[:id])
  end

  # POST /content_partials
  # POST /content_partials.json
  def create
    @content_partial = ContentPartial.new(params[:content_partial])

    respond_to do |format|
      if @content_partial.save
        format.html { redirect_to @content_partial, notice: 'Content partial was successfully created.' }
        format.json { render json: @content_partial, status: :created, location: @content_partial }
      else
        format.html { render action: "new" }
        format.json { render json: @content_partial.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /content_partials/1
  # PUT /content_partials/1.json
  def update
    @content_partial = ContentPartial.find(params[:id])

    respond_to do |format|
      if @content_partial.update_attributes(params[:content_partial])
        format.html { redirect_to @content_partial, notice: 'Content partial was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @content_partial.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /content_partials/1
  # DELETE /content_partials/1.json
  def destroy
    @content_partial = ContentPartial.find(params[:id])
    @content_partial.destroy

    respond_to do |format|
      format.html { redirect_to content_partials_url }
      format.json { head :no_content }
    end
  end
end
