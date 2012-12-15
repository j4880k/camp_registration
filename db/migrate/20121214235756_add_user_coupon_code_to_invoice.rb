class AddUserCouponCodeToInvoice < ActiveRecord::Migration
  def change
    add_column :invoices, :user_coupon_code, :string

  end
end
