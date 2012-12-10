class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.string :resourcetype
      t.string :name
      t.integer :occupancy
      t.text :notes

      t.timestamps
    end
  end
end
