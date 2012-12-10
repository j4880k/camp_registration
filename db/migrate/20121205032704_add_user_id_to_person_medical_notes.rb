class AddUserIdToPersonMedicalNotes < ActiveRecord::Migration
  def change
    add_column :person_medical_notes, :created_by, :integer

  end
end
