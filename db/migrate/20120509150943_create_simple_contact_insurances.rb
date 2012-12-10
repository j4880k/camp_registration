class CreateSimpleContactInsurances < ActiveRecord::Migration
  def change
    create_table :simple_contact_insurances do |t|
      t.integer :simple_contact_id
      t.string  :provider
      t.string :employer
      t.string :policynumber
      t.string :groupname
      t.string :groupnumber
      t.string :notes

      t.timestamps
    end
  end
end
