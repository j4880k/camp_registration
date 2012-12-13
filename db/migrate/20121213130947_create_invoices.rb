class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.integer :user_id
      t.string :reference_code
      t.text :items_hash
      t.string :payment_type
      t.date :payment_date
      t.boolean :is_confirmed
      t.text :broker_stream
      t.string :status

      t.timestamps
    end
  end
end
