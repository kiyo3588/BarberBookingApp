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

    if params[:day].present? && params[:time].present?
      @day = params[:day].to_date
      @time = params[:time].to_time
      @start_time = DateTime.parse(@day.to_s + " " + @time.to_s + " " + "JST")
    else
      # day と time がない場合の処理
      flash[:error] = "日付と時間が指定されていません。"
      redirect_to root_path
    end
  end

  def create
    reservation_params = params.require(:reservation).permit(:day, :time)
  
    reservation_params[:user_id] = current_user.id  # ユーザーIDを取得する方法に応じて変更

    # 日付のフォーマットを変換してパース
    reservation_params[:day] = Date.strptime(reservation_params[:day], "%m月%d日")
    
    # 時間のフォーマットを変換してパース
    reservation_params[:time] = Time.strptime(reservation_params[:time], "%H:%M")

    # 日付と時間を組み合わせてDateTimeオブジェクトを作成
    reservation_params[:start_time] = DateTime.new(reservation_params[:day].year, reservation_params[:day].month, reservation_params[:day].day, reservation_params[:time].hour, reservation_params[:time].min)

    @reservation = Reservation.new(reservation_params)
   
    if @reservation.save
      flash[:success] = "予約を登録しました。"
      redirect_to root_path
    else
      flash[:danger] = "予約をやり直してください。"
      render :new, status: :unprocessable_entity
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:day, :time,)
  end
end
