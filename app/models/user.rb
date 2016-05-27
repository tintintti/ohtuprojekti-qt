class User < ActiveRecord::Base
  validates :uid, uniqueness: true, presence: true

  def ret_posts
    Post.where("uid = ?", self.uid)
  end

  def ret_topics
    Topic.where("uid = ?", self.uid)
  end
end
