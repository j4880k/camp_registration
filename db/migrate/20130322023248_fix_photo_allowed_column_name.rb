class FixPhotoAllowedColumnName < ActiveRecord::Migration
  def up
  end

  def down
  end
  
  def change
    rename_column :people, :photo_allowed, :forbid_photos
    change_column :people, :forbid_photos, :boolean, :default => true
  end
end
