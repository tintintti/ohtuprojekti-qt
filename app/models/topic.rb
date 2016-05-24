class Topic < ActiveRecord::Base
  has_many :posts

  def ret_posts
    Post.where("tid = ?", self.tid)
  end
end
