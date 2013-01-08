require 'spec_helper'

describe PaymentNotificationsController do
  fixtures :all
  render_views

  # it "create action should render new template when model is invalid" do
  #   PaymentNotification.any_instance.stubs(:valid?).returns(false)
  #   post :create
  #   response.should render_template(:new)
  # end
  it "true should be true" do
    true.should eq(true)
  end
  it "create action should create a record" do
    PaymentNotification.any_instance.stubs(:valid?).returns(true)
    post :create
  end
  
end
