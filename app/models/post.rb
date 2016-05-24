class Post < ActiveRecord::Base
  belongs_to :topic

  def ret_user
    User.find_by_uid(self.uid)
  end
end
