class CreateSystemMessages < ActiveRecord::Migration
  def self.up
    create_table :system_messages do |t|
      t.text :message
      t.string :reference_class_type
      t.integer :reference_id
      t.string :calling_method
      t.text :exception_audit
      t.string :priority
      t.string :status
      t.integer :last_modified_by
      t.timestamp :last_modified_dt
      t.timestamps
    end
  end

  def self.down
    drop_table :system_messages
  end
end
