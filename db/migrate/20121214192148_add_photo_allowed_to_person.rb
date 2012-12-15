class AddPhotoAllowedToPerson < ActiveRecord::Migration
  def change
    add_column :people, :photo_allowed, :boolean

  end
end
