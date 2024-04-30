class Reservation < ApplicationRecord
  belongs_to :user

  validates :start_time, uniqueness: { scope: :user_id }
  validates :start_time, uniqueness: true
  validates :start_time, presence: true
  validate :start_time_cannot_be_in_the_past

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

  private

  def start_time_cannot_be_in_the_past
    if start_time.present? && start_time < Time.current
      errors.add(:start_time, "は現在時刻より後の時間を選択してください")
    end
  end
end
