class AddRepliesCountToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :replies_count, :integer, default: 0
  end
  add_index :users, :replies_count
end
