class GerritOwner < ActiveRecord::Base
  validates :account_id, uniqueness: true
  
  has_many :gerrit_sanity_reviews
  has_many :gerrit_code_reviews
  has_many :gerrit_changes
  has_many :gerrit_messages
end
