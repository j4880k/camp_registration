class CreateReservationResources < ActiveRecord::Migration
  def change
    create_table :reservation_resources do |t|
      t.integer :reservation_id
      t.integer :resource_id

      t.timestamps
    end
  end
end
