class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.integer :person_id
      t.integer :event_id
      t.boolean :is_deleted
      t.boolean :is_staffing
      t.text :notes
      t.float :discount
      t.float :amountpaid

      t.timestamps
    end
  end
end
