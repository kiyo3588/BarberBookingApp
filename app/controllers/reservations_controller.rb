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
      # フォームから渡された日付と時間を合成してDateTimeオブジェクトを作成
      combined_datetime = DateTime.parse("#{params[:day]} #{params[:time]}")
      @reservation.start_time = combined_datetime
    end

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
    # フォームからの日付データを正しい形式に変換する
    reservation_params = params.require(:reservation).permit(:day, :time)
    reservation_params[:user_id] = current_user.id
    reservation_params[:day] = Date.strptime(reservation_params[:day], '%m月%d日').strftime('%Y-%m-%d')
    
    @reservation = Reservation.new(reservation_params)

    # start_time を生成するロジックを修正する
    if @reservation.day.present? && @reservation.time.present?
      combined_datetime = DateTime.parse("#{@reservation.day} #{@reservation.time}")
      @reservation.start_time = combined_datetime
    end
  
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
