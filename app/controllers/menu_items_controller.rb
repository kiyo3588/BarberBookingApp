class MenuItemsController < ApplicationController

  def index
    @menu_items = MenuItem.all
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

    private

    def menu_item_params
      params.require(:menu_item).permit(:menu_name, :description, :price, :order)
    end
end
