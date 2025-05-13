class DropHolidaysTable < ActiveRecord::Migration[7.1]
  def up
    drop_table :holidays
  end

  def down
    create_table :holidays do |t|
      t.date :date
      t.string :description
      
      t.timestamps
    end
  end
end