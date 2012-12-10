class CreatePersonEmails < ActiveRecord::Migration
  def change
    create_table :person_emails do |t|
      t.integer :person_id
      t.integer :email_id
      t.string :notes

      t.timestamps
    end
  end
end
