class CreatePersonMedicalNotes < ActiveRecord::Migration
  def change
    create_table :person_medical_notes do |t|
      t.integer :person_id
      t.string :notes

      t.timestamps
    end
  end
end
