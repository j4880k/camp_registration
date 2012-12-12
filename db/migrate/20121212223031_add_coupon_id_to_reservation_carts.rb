class AddCouponIdToReservationCarts < ActiveRecord::Migration
  def change
    add_column :reservation_carts, :coupon_id, :integer

  end
end
