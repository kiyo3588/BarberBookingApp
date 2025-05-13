class ReservationsController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user, only: [:index] # indexアクションのみ管理者のみに制限


  def show_week
    # 週単位のカレンダーを表示するための追加ロジックが必要な場合はここに記述
    @start_date = params[:start_date] ? Date.parse(params[:start_date]) : Date.today.beginning_of_week
    @date_range = (@start_date..(@start_date + 6.days)).to_a

    # 予約時間の設定（営業時間に合わせて調整）
    @time_slots = []
    (10..18).each do |hour|
      @time_slots << Time.new(2000, 1, 1, hour, 0, 0)
      @time_slots << Time.new(2000, 1, 1, hour, 30, 0)
    end

    # 各日付の予約データを準備
    @week_data = @date_range.map do |date|
      {
        date: date,
        reservations: Reservation.where("DATE(start_time) = ?", date).order(:start_time)
      }
    end

    # 表示期間の休業日を取得
    @closed_days = ClosedDay.in_range(@start_date, @start_date + 6.days)
  end
  
  def new
    @reservation = Reservation.new

    if params[:day].present? && params[:time].present?
      # フォームから渡された日付と時間を合成してDateTimeオブジェクトを作成
      @day = params[:day].to_date
      @time = params[:time].to_time
      
      # 休業日チェック
      if ClosedDay.closed?(@day)
        flash[:alert] = "申し訳ありませんが、#{@day.strftime('%Y年%m月%d日')}は休業日のため予約できません。"
        redirect_to week_calendar_path(start_date: @day.beginning_of_week.strftime('%Y-%m-%d'))
        return
      end

      # 日付と時間を合成してDateTimeオブジェクトを作成
      combined_datetime = DateTime.parse("#{params[:day]} #{params[:time]}")
      @reservation.start_time = combined_datetime
    else
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

  # def create_visit_history
  #   @reservation = Reservation.find(params[:id])

  #   if @reservation.visited?
  #     flash[:warning] = "この予約は既に来店済みです。"
  #   else
  #     # 予約された日時を visit_time として来店履歴に登録する
  #     @reservation.update(visit_time: @reservation.start_time)
    
  #     # 必要なリダイレクトやフラッシュメッセージを設定する
  #     flash[:success] = "来店履歴を登録しました。"
  #   end
  #   redirect_to root_path
  # end

  def mark_as_visited
    @reservation = Reservation.find(params[:id])
    user = @reservation.user
    
    if user.update(visited_time: @reservation.start_time)
      flash[:success] = "来店を記録しました。"
    else
      flash[:error] = "来店の記録に失敗しました: #{user.errors.full_messages.join(', ')}"
    end
    
    redirect_to reservations_path
  end

  private

  def reservation_params
    params.require(:reservation).permit(:day, :time,)
  end

  def admin_user
    redirect_to root_url unless current_user&.admin?
  end
end
