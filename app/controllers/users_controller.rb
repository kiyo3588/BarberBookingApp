class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:index, :destroy]

  def index
    if current_user.admin?
      @users = User.where.not(id: current_user.id).paginate(page: params[:page])
    else
      @users = User.paginate(page: params[:page])
    end
  end

  def show
    @user = User.find(params[:id])
    @reservation = @user.reservation
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = '新規作成に成功しました。'
      redirect_to @user
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "ユーザー情報を更新しました。"
      redirect_to @user
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "#{@user.name}のデータを削除しました。"
    redirect_to user_url
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
  
   # beforeフィルター
 
   # アクセスしたユーザーが現在ログインしているユーザーか確認します。
   def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
   end

end
