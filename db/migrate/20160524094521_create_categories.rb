class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.integer :cid
      t.string :name
      t.string :description
      t.string :slug
      t.string :parentCid
      t.integer :topic_count
      t.integer :post_count
      t.boolean :disabled
      t.integer :order
      t.string :link
      t.integer :numRecentReplies
      t.integer :totalPostCount
      t.integer :totalTopicCount

      t.timestamps null: false
    end
  end
end
