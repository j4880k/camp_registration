class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :Street1
      t.string :Street2
      t.string :Street3
      t.string :City
      t.string :State
      t.string :zipcode
      t.string :notes

      t.timestamps
    end
  end
end
