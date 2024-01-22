class MenuItemsController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_menu_item, only: [:create, :edit, :update, :destroy]

  def index
    @menu_items = MenuItem.order(:order)
  end

  def new
    @menu_item = MenuItem.new
  end

  def create
    @menu_item = MenuItem.new(menu_item_params)
    if @menu_item.save
      flash[:success] = "メニューアイテムが追加されました。"
      redirect_to menu_items_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @menu_item.update(menu_item_params)
      flash[:success] = "メニューアイテムが更新されました。"
      redirect_to menu_items_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @menu_item.destroy
    flash[:success] = "#{@menu_item.menu_name}のデータを削除しました。"
    redirect_to menu_item_path
  end

    private

    def set_menu_item
      @menu_item = MenuItem.find(params[:id])
    end

    def menu_item_params
      params.require(:menu_item).permit(:menu_name, :description, :price, :order)
    end
end
