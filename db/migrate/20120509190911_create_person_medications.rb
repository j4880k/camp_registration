class CreatePersonMedications < ActiveRecord::Migration
  def change
    create_table :person_medications do |t|
      t.integer :person_id
      t.string :medicationname
      t.string :notes
      t.integer :isactive

      t.timestamps
    end
  end
end
