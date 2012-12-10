class CreateKeywords < ActiveRecord::Migration
  def change
    create_table :keywords do |t|
      t.string :listKey
      t.string :listValue
      t.string :listLabel

      t.timestamps
    end
  end
end
