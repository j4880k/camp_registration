class CreatePaymentNotifications < ActiveRecord::Migration
  def self.up
    create_table :payment_notifications do |t|
      t.text :params
      t.string :reference_code
      t.integer :invoice_id
      t.string :payment_status
      t.string :transaction_id
      t.timestamps
    end
  end

  def self.down
    drop_table :payment_notifications
  end
end
