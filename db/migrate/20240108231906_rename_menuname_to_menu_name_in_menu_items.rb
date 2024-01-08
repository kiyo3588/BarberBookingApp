class RenameMenunameToMenuNameInMenuItems < ActiveRecord::Migration[7.1]
  def change
    rename_column :menu_items, :menuname, :menu_name
  end
end
