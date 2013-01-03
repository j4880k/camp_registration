class AddBillingStatusToReservation < ActiveRecord::Migration
  def change
    add_column :reservations, :billing_status, :string
  
  end
end
