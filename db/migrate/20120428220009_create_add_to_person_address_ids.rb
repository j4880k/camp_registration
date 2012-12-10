class CreateAddToPersonAddressIds < ActiveRecord::Migration
  def change
    drop_table :people_addresses
    # create_table :people_addresses, :id => false do |t|
    create_table :people_addresses do |t|
      t.integer :person_id
      t.integer :address_id
      t.integer "is_primary"
      t.integer "is_deleted"
      t.string  "notes"
      t.timestamps
    end        
    
  end
end
