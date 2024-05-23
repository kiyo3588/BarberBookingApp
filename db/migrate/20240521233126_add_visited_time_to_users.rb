class AddVisitedTimeToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :visited_time, :datetime
  end
end
