class CreateSimpleContactEmails < ActiveRecord::Migration
  def change
    create_table :simple_contact_emails do |t|
      t.integer :simple_contact_id
      t.string :emailaddress
      t.string :nickname
      t.string :notes

      t.timestamps
    end
  end
end
