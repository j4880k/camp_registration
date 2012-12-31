class AddMedsToPerson < ActiveRecord::Migration
  def change
    add_column :people, :allow_tylenol, :boolean

    add_column :people, :allow_sudafed, :boolean

    add_column :people, :allow_ibuprofin, :boolean

    add_column :people, :allow_mylanta, :boolean

    add_column :people, :allow_cough_medicine, :boolean

    add_column :people, :allow_benadryl, :boolean

  end
end
