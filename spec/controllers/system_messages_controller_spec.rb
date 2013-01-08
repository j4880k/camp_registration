require File.dirname(__FILE__) + '/../spec_helper'

describe SystemMessagesController do
  fixtures :all
  render_views

  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end

  it "show action should render show template" do
    get :show, :id => SystemMessage.first
    response.should render_template(:show)
  end

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    SystemMessage.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    SystemMessage.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(system_message_url(assigns[:system_message]))
  end

  it "edit action should render edit template" do
    get :edit, :id => SystemMessage.first
    response.should render_template(:edit)
  end

  it "update action should render edit template when model is invalid" do
    SystemMessage.any_instance.stubs(:valid?).returns(false)
    put :update, :id => SystemMessage.first
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    SystemMessage.any_instance.stubs(:valid?).returns(true)
    put :update, :id => SystemMessage.first
    response.should redirect_to(system_message_url(assigns[:system_message]))
  end

  it "destroy action should destroy model and redirect to index action" do
    system_message = SystemMessage.first
    delete :destroy, :id => system_message
    response.should redirect_to(system_messages_url)
    SystemMessage.exists?(system_message.id).should be_false
  end
end
