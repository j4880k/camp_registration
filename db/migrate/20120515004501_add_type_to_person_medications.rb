class AddTypeToPersonMedications < ActiveRecord::Migration
  def change
    add_column :person_medications, :medication_type, :string
  end
end
