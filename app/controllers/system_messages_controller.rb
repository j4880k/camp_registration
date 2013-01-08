class SystemMessagesController < ApplicationController
  def index
    @system_messages = SystemMessage.all
  end

  def show
    @system_message = SystemMessage.find(params[:id])
  end

  def new
    @system_message = SystemMessage.new
  end

  def create
    @system_message = SystemMessage.new(params[:system_message])
    if @system_message.save
      redirect_to @system_message, :notice => "Successfully created system message."
    else
      render :action => 'new'
    end
  end

  def edit
    @system_message = SystemMessage.find(params[:id])
  end

  def update
    @system_message = SystemMessage.find(params[:id])
    if @system_message.update_attributes(params[:system_message])
      redirect_to @system_message, :notice  => "Successfully updated system message."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @system_message = SystemMessage.find(params[:id])
    @system_message.destroy
    redirect_to system_messages_url, :notice => "Successfully destroyed system message."
  end
end
