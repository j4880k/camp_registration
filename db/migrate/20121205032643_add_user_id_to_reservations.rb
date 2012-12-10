class AddUserIdToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :updated_by, :integer

  end
end
