class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.string :name
      t.string :code
      t.string :discount_type
      t.float :discount_value
      t.boolean :code_mask
      t.integer :use_limit
      t.text :description
      t.date :effective_start_date
      t.date :effective_end_date

      t.timestamps
    end
  end
end
