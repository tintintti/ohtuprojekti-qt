class AddColumnTimestampToReputationPostTopics < ActiveRecord::Migration
  def change
    add_column :reputation_post_topics, :timestamp, :integer, limit:8
  end
end
