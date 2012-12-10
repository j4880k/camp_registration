require 'spec_helper'

describe "reservations/index" do
  before(:each) do
    assign(:reservations, [
      stub_model(Reservation,
        :person_id => 1,
        :event_id => 2,
        :is_deleted => false,
        :is_staffing => false,
        :notes => "MyText",
        :discount => 1.5,
        :amountpaid => 1.5
      ),
      stub_model(Reservation,
        :person_id => 1,
        :event_id => 2,
        :is_deleted => false,
        :is_staffing => false,
        :notes => "MyText",
        :discount => 1.5,
        :amountpaid => 1.5
      )
    ])
  end

  it "renders a list of reservations" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
  end
end
