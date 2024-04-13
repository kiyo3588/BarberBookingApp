class Reservation < ApplicationRecord

  def self.reservation_data(start_date)
    end_date = start_date + 6.days
    reservations = where(day: start_date..end_date).order(:day, :time)
    date_range = (start_date..end_date).to_a

    reservation_data = []
    date_range.each do |day|
      reservations_for_day = reservations.select { |reservation| reservation.day == day }
      daily_data = { day: day, reservations: reservations_for_day }
      reservation_data << daily_data
    end

    reservation_data
  end
end
