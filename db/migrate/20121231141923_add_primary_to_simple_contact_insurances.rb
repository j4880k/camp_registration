class AddPrimaryToSimpleContactInsurances < ActiveRecord::Migration
  def change
    add_column :simple_contact_insurances, :is_primary, :boolean

  end
end
