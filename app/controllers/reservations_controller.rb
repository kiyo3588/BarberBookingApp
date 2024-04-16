class ReservationsController < ApplicationController
  before_action :logged_in_user

  def show_week
    # 週単位のカレンダーを表示するための追加ロジックが必要な場合はここに記述
    @start_date = params[:start_date].to_date
    @reservation_data = Reservation.reservation_data(@start_date)
    @date_range = (@start_date..(@start_date + 6.days)).to_a
  end
  
  def new
    @reservation = Reservation.new
    @day = params[:day]
    @time = params[:time]
    if @day && @time
      @start_time = DateTime.parse(@day + " " + @time + " " + "JST")
    else
      # day と time がない場合の処理
      flash[:error] = "日付と時間が指定されていません。"
      redirect_to root_path
    end
  end

  def create
    @reservation = Reservation.new(reservation_params)
   
    if @reservation.save
      flash[:success] = "予約を登録しました。"
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:day, :time)
  end
end
