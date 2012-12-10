class CreateInsurances < ActiveRecord::Migration
  def change
    create_table :insurances do |t|
      t.string :provider
      t.string :employer
      t.string :policyNumber
      t.string :groupName
      t.string :groupNumber
      t.string :notes

      t.timestamps
    end
  end
end
