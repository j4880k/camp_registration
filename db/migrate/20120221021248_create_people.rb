class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :firstname
      t.string :lastname
      t.string :middleinit
      t.date :birthdate
      t.string :nickname
      t.string :gender
      t.date :date_created
      t.string :password

      t.timestamps
    end
  end
end
