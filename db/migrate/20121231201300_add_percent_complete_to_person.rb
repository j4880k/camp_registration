class AddPercentCompleteToPerson < ActiveRecord::Migration
  def change
    add_column :people, :pct_complete, :integer

  end
end
