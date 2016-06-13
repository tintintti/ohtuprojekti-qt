class GerritMessage < ActiveRecord::Base
  belongs_to :gerrit_owner
  belongs_to :gerrit_change
end
