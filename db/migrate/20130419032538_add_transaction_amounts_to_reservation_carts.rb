class AddTransactionAmountsToReservationCarts < ActiveRecord::Migration
  def change
    add_column :reservation_carts, :line_discount, :decimal, :precision => 8, :scale => 2
    add_column :reservation_carts, :line_price, :decimal, :precision => 8, :scale => 2
  end
end
