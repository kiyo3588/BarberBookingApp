class Reservation < ApplicationRecord
  belongs_to :user

  # 開始時間は現在時刻より後でなければならない
  validates :start_time, presence: true, uniqueness: { scope: :user_id }
  validate :start_time_cannot_be_in_the_past
  validate :cannot_overlap_existing_reservation, on: :create

  # ユーザーごとに1つの予約しか作成できない
  validates :user_id, uniqueness: true, on: :create

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

  def visited?
    user.visited_time.present? && user.visited_time >= start_time
  end

  private

  def start_time_cannot_be_in_the_past
    if start_time.present? && start_time < Time.current
      errors.add(:start_time, "は現在時刻より後の時間を選択してください")
    end
  end

  def cannot_overlap_existing_reservation
    if Reservation.exists?(day: day, time: start_time)
      errors.add(:start_time, "はすでに予約されています")
    end
  end
end
