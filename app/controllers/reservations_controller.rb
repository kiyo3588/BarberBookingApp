class ReservationsController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user, only: [:index] # indexアクションのみ管理者のみに制限


  def show_week
    # 週単位のカレンダーを表示するための追加ロジックが必要な場合はここに記述
    @start_date = params[:start_date].to_date
    @reservation_data = Reservation.reservation_data(@start_date)
    @date_range = (@start_date..(@start_date + 6.days)).to_a
  end
  
  def new
    @reservation = Reservation.new
    @day = Date.current # 初期値を設定
    @time = Time.current # 現在時刻を初期値として設定

    if params[:day].present? && params[:time].present?
      # フォームから渡された日付と時間を合成してDateTimeオブジェクトを作成
      combined_datetime = DateTime.parse("#{params[:day]} #{params[:time]}")
      @reservation.start_time = combined_datetime
      @day = params[:day].to_date
      @time = params[:time].to_time
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
      flash.now[:danger] = @reservation.errors.full_messages.join(", ")
      @start_date = @reservation.start_time.to_date  # 選択した日付を設定
      @reservation_data = Reservation.reservation_data(@start_date)  # 予約データを取得
      @date_range = (@start_date..(@start_date + 6.days)).to_a  # 日付範囲を設定
      render 'show_week', status: :unprocessable_entity
    end
  end

  def destroy
    reservation = Reservation.find(params[:id])
    reservation.destroy
    flash[:success] = "予約を削除しました。"
    redirect_to root_path
  end

  def index
    @reservations = Reservation.all.order(:day, :start_time)
  end

  def create_visit_history
    @reservation = Reservation.find(params[:id])

    if @reservation.visited?
      flash[:warning] = "この予約は既に来店済みです。"
    else
      # 予約された日時を visit_time として来店履歴に登録する
      @reservation.update(visit_time: @reservation.start_time)
    
      # 必要なリダイレクトやフラッシュメッセージを設定する
      flash[:success] = "来店履歴を登録しました。"
    end
    redirect_to root_path
  end

  private

  def reservation_params
    params.require(:reservation).permit(:day, :time,)
  end

  def admin_user
    redirect_to root_url unless current_user&.admin?
  end
end
