class AddEmailToReputationPostTopic < ActiveRecord::Migration
  def change
    add_column :reputation_post_topics, :email, :string
  end
end
