class CreateReservationCarts < ActiveRecord::Migration
  def change
    create_table :reservation_carts do |t|
      t.integer :reservation_id
      t.string :status
      t.string :reference_code
      t.integer :invoice_id

      t.timestamps
    end
  end
end
