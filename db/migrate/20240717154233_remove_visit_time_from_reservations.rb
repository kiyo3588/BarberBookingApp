class RemoveVisitTimeFromReservations < ActiveRecord::Migration[7.1]
  def up
    remove_column :reservations, :visit_time
  end

  def down
    add_column :reservations, :visit_time, :datetime
  end
end
