class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :pid
      t.integer :did
      t.integer :tid
      t.string :content
      t.integer :timestamp
      t.integer :reputation
      t.integer :votes
      t.integer :edited
      t.boolean :deleted

      t.timestamps null: false
    end
  end
end
