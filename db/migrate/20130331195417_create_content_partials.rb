class CreateContentPartials < ActiveRecord::Migration
  def change
    create_table :content_partials do |t|
      t.string :keyval
      t.integer :priority_index, :default => 0 #lowest is highest priority
      t.boolean :is_active, :default => false
      t.text :content
      t.text :rendered_content
      t.date :pub_start, :default => Date.today
      t.date :pub_end, :default => Date.today.years_since(1)
      t.integer :user_id
      t.text :notes

      t.timestamps
    end
  end
end
