class CreatePersonSimpleContacts < ActiveRecord::Migration
  def change
    create_table :person_simple_contacts do |t|
      t.integer :person_id
      t.integer :simple_contact_id
      t.string :notes

      t.timestamps
    end
  end
end
