class AddVisitTimeToReservations < ActiveRecord::Migration[7.1]
  def change
    add_column :reservations, :visit_time, :datetime
  end
end
