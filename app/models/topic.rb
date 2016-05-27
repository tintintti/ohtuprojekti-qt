class Topic < ActiveRecord::Base
  has_many :posts

  validates :tid, uniqueness: true, presence: true

  def ret_posts
    Post.where("tid = ?", self.tid)
  end

  def first_post
    Post.find_by_tid_and_index(self.tid, 0)
  end
end
