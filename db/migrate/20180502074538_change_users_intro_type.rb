class ChangeUsersIntroType < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :introduction, :text
  end
end
