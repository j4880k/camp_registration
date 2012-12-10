class CreatePersonAddresses < ActiveRecord::Migration
  def change
    create_table :person_addresses do |t|
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
