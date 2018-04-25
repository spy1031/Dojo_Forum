class CreateCollections < ActiveRecord::Migration[5.1]
  def change
    create_table :collections do |t|
      t.integer :user_id
      t.integer :article_id
      t.timestamps
    end
    add_index :collections, [:user_id, :article_id]
  end
end
