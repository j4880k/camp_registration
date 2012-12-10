class AddAllergyTypeToPersonAllergies < ActiveRecord::Migration
  def change
    add_column :person_allergies, :allergy_type, :string
  end
end
