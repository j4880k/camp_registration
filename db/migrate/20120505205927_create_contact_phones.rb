class CreateContactPhones < ActiveRecord::Migration
  def change
    create_table :contact_phones do |t|
      t.integer :contact_id
      t.integer :phone_id
      t.string :notes

      t.timestamps
    end
  end
end
