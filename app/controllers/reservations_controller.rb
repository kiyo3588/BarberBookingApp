class ReservationsController < ApplicationController

  def show_week
    # 週単位のカレンダーを表示するための追加ロジックが必要な場合はここに記述
    @start_date = params[:start_date].to_date
    end_date = @start_date + 3.days
    start_date = @start_date - 3.days

    @date_range = (start_date..end_date).to_a
    @reservations = Reservation.where(day: @start_date..end_date)
  end
end
