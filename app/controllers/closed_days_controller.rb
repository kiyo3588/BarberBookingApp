class ClosedDaysController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user
  before_action :set_closed_day, only: [:edit, :update, :destroy]

  def index
    @closed_days = ClosedDay.order(date: :asc)
    @closed_day = ClosedDay.new
  end

  def create
    @closed_day = ClosedDay.new(closed_day_params)

    if @closed_day.save
      flash[:success] = "休業日を登録しました"
      redirect_to closed_days_path
    else
      @closed_days = ClosedDay.order(date: :asc)
      flash.now[:danger] = "休業日の登録に失敗しました: #{@closed_day.errors.full_messages.join(', ')}"
      render 'index', status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @closed_day.update(closed_day_params)
      flash[:success] = "休業日情報を更新しました"
      redirect_to closed_days_path
    else
      flash.now[:danger] = "休業日情報の更新に失敗しました: #{@closed_day.errors.full_messages.join(', ')}"
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @closed_day.destroy
    flash[:success] = "休業日を削除しました"
    redirect_to closed_days_path
  end

  private

  def set_closed_day
    @closed_day = ClosedDay.find(params[:id])
  end

  def closed_day_params
    params.require(:closed_day).permit(:date, :reason)
  end

  def admin_user
    redirect_to root_url unless current_user&.admin?
  end
end