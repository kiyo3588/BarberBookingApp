class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
include SessionsHelper


  private
  
  # ログイン済みのユーザーか確認します。
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "ログインしてください。"
      redirect_to login_url
    end
  end

  # システム管理権限所有かどうか判定します。
  def admin_user
  if current_user.nil? || !current_user.admin?
    redirect_to root_url
  end
  end
end
