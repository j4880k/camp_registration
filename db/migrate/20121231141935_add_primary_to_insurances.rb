class AddPrimaryToInsurances < ActiveRecord::Migration
  def change
    add_column :insurances, :is_primary, :boolean

  end
end
