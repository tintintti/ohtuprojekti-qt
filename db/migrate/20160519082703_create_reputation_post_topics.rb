class CreateReputationPostTopics < ActiveRecord::Migration
  def change
    create_table :reputation_post_topics do |t|
      t.integer :tid
      t.integer :reputation
      t.integer :postcount

      t.timestamps null: false
    end
  end
end
