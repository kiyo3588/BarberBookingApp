class DropBusinessDaysTable < ActiveRecord::Migration[7.1]
  def up
    drop_table :business_days
  end

  def down
    create_table :business_days do |t|
      t.date :date
      t.integer  :status
      t.integer :day_of_week
      
      t.timestamps
    end
  end
end
