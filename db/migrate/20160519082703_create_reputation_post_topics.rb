class CreateReputationPostTopics < ActiveRecord::Migration
  def change
    create_table :reputation_post_topics do |t|
      t.integer :tid
      t.integer :reputation
      t.integer :postcount
      t.string :email
      t.integer :timestamp, :limit => 8

      t.timestamps null: false
    end
  end
end
