class RenameTypeInCategory < ActiveRecord::Migration[5.1]
  def change
    rename_column :categories, :type, :name
  end
end
