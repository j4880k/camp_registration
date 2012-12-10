require 'spec_helper'

describe "reservations/new" do
  before(:each) do
    assign(:reservation, stub_model(Reservation,
      :person_id => 1,
      :event_id => 1,
      :is_deleted => false,
      :is_staffing => false,
      :notes => "MyText",
      :discount => 1.5,
      :amountpaid => 1.5
    ).as_new_record)
  end

  it "renders new reservation form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => reservations_path, :method => "post" do
      assert_select "input#reservation_person_id", :name => "reservation[person_id]"
      assert_select "input#reservation_event_id", :name => "reservation[event_id]"
      assert_select "input#reservation_is_deleted", :name => "reservation[is_deleted]"
      assert_select "input#reservation_is_staffing", :name => "reservation[is_staffing]"
      assert_select "textarea#reservation_notes", :name => "reservation[notes]"
      assert_select "input#reservation_discount", :name => "reservation[discount]"
      assert_select "input#reservation_amountpaid", :name => "reservation[amountpaid]"
    end
  end
end
