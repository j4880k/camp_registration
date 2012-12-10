class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.datetime :date_begin
      t.datetime :date_end
      t.float :price
      t.text :notes
      t.string :eventname

      t.timestamps
    end
  end
end
