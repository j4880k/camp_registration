class AddEnvHeadersToPaymentNotification < ActiveRecord::Migration
  def change
    add_column :payment_notifications, :env_headers, :text

  end
end
