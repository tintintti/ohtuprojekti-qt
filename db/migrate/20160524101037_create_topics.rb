class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.integer :tid
      t.integer :uid
      t.integer :cid
      t.integer :mainPid
      t.string :title
      t.string :slug
      t.integer :timestamp, :limit => 8
      t.integer :lastposttime, :limit => 8
      t.integer :postcount
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
