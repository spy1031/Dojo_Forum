class RenameWatchCountInArticles < ActiveRecord::Migration[5.1]
  def change
    rename_column :articles, :watches_count, :viewes_count
  end
end
