class CreatePersonOrganizations < ActiveRecord::Migration
  def change
    create_table :person_organizations do |t|
      t.integer :organization_id
      t.integer :person_id
      t.string :notes

      t.timestamps
    end
  end
end
