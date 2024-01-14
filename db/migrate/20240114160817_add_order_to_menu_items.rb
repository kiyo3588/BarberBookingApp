class AddOrderToMenuItems < ActiveRecord::Migration[7.1]
  def change
    add_column :menu_items, :order, :integer
  end
end
