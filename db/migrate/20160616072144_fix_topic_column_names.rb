class FixTopicColumnNames < ActiveRecord::Migration
  def change
    rename_column :topics, :mainpid, :mainPid
    rename_column :topics, :isquestion, :isQuestion
    rename_column :topics, :issolved, :isSolved
    rename_column :topics, :relativetime, :relativeTime
    rename_column :topics, :lastposttimeiso, :lastposttimeISO
  end
end
