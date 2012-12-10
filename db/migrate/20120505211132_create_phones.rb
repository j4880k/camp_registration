class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.integer :phoneNumber
      t.string :phoneType
      t.string :notes

      t.timestamps
    end
  end
end
