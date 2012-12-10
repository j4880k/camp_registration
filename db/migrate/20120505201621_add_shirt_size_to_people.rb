class AddShirtSizeToPeople < ActiveRecord::Migration
  def change
    add_column :people, :shirtsize, :string

  end
end
