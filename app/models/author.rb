class Author < ActiveRecord::Base
  has_many :commits
  self.primary_key = "id"
end
