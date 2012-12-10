class CreatePersonAllergies < ActiveRecord::Migration
  def change
    create_table :person_allergies do |t|
      t.integer :person_id
      t.string :allergyname
      t.string :notes

      t.timestamps
    end
  end
end
