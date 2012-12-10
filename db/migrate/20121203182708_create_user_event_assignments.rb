class CreateUserEventAssignments < ActiveRecord::Migration
  def change
    create_table :user_event_assignments do |t|
      t.integer :user_id
      t.integer :event_id
      t.string :assignment

      t.timestamps
    end
  end
end
