class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :pid
      t.integer :uid
      t.integer :tid
      t.string :content
      t.string :timestamp
      t.integer :reputation
      t.integer :votes
      t.string :edited
      t.boolean :deleted
      t.integer :index

      t.timestamps null: false
    end
  end
end
