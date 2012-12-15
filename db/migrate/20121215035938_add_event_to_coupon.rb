class AddEventToCoupon < ActiveRecord::Migration
  def change
    add_column :coupons, :event_id, :integer

  end
end
