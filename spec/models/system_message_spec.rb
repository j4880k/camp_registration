require File.dirname(__FILE__) + '/../spec_helper'

describe SystemMessage do
  it "should be valid" do
    SystemMessage.new.should be_valid
  end
end
