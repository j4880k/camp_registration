class CreateSimpleContacts < ActiveRecord::Migration
  def change
    create_table :simple_contacts do |t|
      t.string :firstname
      t.string :lastname
      t.string :relationship
      t.string :contacttype
      t.text :notes

      t.timestamps
    end
  end
end
