require 'spec_helper'

describe "resources/new" do
  before(:each) do
    assign(:resource, stub_model(Resource,
      :type => "",
      :name => "MyString",
      :occupancy => 1,
      :notes => "MyText"
    ).as_new_record)
  end

  it "renders new resource form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => resources_path, :method => "post" do
      assert_select "input#resource_type", :name => "resource[type]"
      assert_select "input#resource_name", :name => "resource[name]"
      assert_select "input#resource_occupancy", :name => "resource[occupancy]"
      assert_select "textarea#resource_notes", :name => "resource[notes]"
    end
  end
end
