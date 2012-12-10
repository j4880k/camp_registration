class CreateFixPersonAddressTables < ActiveRecord::Migration
  def change
    # drop_table :people_addresses
    # drop_table :person_addresses
    create_table "person_address", :id => false, :force => true do |t|
      t.integer  "person_id"
      t.integer  "address_id"
      t.integer  "is_primary"
      t.integer  "is_deleted"
      t.string   "notes"
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
    end    
  end
end
