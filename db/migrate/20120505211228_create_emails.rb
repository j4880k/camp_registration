class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.string :emailAddress
      t.string :nickname
      t.string :notes

      t.timestamps
    end
  end
end
