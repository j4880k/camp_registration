class AddLockedToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :locked, :boolean

  end
end
