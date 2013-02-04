class ChangePhoneFieldDataTypes < ActiveRecord::Migration
  def up
    change_column :phones, :phoneNumber, :integer, :limit => 8
    change_column :simple_contact_phones, :scphonenumber, :integer, :limit => 8    
  end

  def down
  change_column :phones, :phoneNumber, :integer
  change_column :simple_contact_phones, :scphonenumber, :integer
  end
end
