class PaymentNotification < ActiveRecord::Base
  attr_accessible :params, :reference_code, :invoice_id, :payment_status, :transaction_id
  belongs_to :invoice
  serialize :params
  after_create :mark_cart_as_purchased

  private

  def mark_cart_as_purchased
    #link to the invoice and mark it as paid
    if payment_status == "Completed"
      # cart.update_attribute(:purchased_at, Time.now)
      puts "Yay, we have paid #{params[:invoice_id]}"
    else
      puts "Boo, we failed"
    end
  end
end
