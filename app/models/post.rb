class Post < ActiveRecord::Base
  belongs_to :topic

  validates :pid, uniqueness: true, presence: true

  def ret_user
    User.find_by_uid(self.uid)
  end
end
