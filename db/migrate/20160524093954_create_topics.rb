class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.integer :tid
      t.integer :did
      t.10 :cid
      t.integer :mainPid
      t.string :title
      t.string :slug
      t.integer :timestamp
      t.integer :lastposttime
      t.string :post
      t.integer :count
      t.integer :viewcount
      t.boolean :locked
      t.boolean :pinned
      t.integer :isQuestion
      t.integer :isSolved
      t.string :relativeTime
      t.string :lastposttimeISO

      t.timestamps null: false
    end
  end
end
