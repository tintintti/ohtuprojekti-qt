class GerritCodeReview < ActiveRecord::Base
  belongs_to :gerrit_owner
  belongs_to :gerrit_changes
end
