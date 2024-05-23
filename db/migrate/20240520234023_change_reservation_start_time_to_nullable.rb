class ChangeReservationStartTimeToNullable < ActiveRecord::Migration[7.1]
  def change
    change_column_null :reservations, :start_time, true
  end
end
