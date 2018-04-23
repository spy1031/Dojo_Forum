class RenameViewesCountInArticles < ActiveRecord::Migration[5.1]
  def change
    rename_column :articles, :viewes_count, :views_count
  end
end
