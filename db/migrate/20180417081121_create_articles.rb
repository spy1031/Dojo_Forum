class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.integer :authority, null: false
      t.boolean :status
      t.integer :watches_count, default: 0
      t.integer :replies_count, default: 0
      t.datetime :last_reply_time
      t.integer :category_id
      t.integer :user_id
      t.timestamps
    end

    add_index :articles, :user_id
    add_index :articles, :last_reply_time
    add_index :articles, :category_id
  end

  
end
