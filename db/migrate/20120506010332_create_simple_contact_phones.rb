class CreateSimpleContactPhones < ActiveRecord::Migration
  def change
    create_table :simple_contact_phones do |t|
      t.integer :simple_contact_id
      t.integer :phone_id
      t.integer :scphonenumber
      t.string :scphonetype
      t.string :notes

      t.timestamps
    end
  end
end
