class ChangeTimeColumnTypeInReservations < ActiveRecord::Migration[7.1]
  def change
    change_column :reservations, :time, :time
  end
end
