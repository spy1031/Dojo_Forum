class CreateReplies < ActiveRecord::Migration[5.1]
  def change
    create_table :replies do |t|
      t.integer :user_id
      t.integer :article_id
      t.text :content
      t.timestamps
    end

    add_index :replies, [:article_id, :user_id ]
  end
end
