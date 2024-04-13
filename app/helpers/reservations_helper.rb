module ReservationsHelper
  def times
    times = ["9:00",
             "9:30",
             "10:00",
             "10:30",
             "11:00",
             "11:30",
             "13:00",
             "13:30",
             "14:00",
             "15:00",
             "15:30",
             "16:00",
             "16:30",
             "17:00"]
  end

  def check_reservation(reservations, day, time)
    return false if reservations.blank?

    reservations.any? { |reservation| reservation.day == day && reservation.time == time }
  end

end
