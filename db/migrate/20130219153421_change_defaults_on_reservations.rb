class ChangeDefaultsOnReservations < ActiveRecord::Migration
  def up
    change_column :reservations, :is_deleted, :boolean, :default => false
    change_column :reservations, :is_staffing, :boolean, :default => false
    change_column :reservations, :locked, :boolean, :default => false
  end

  def down
  end
end
