class Topic < ActiveRecord::Base
  validates :tid, uniqueness:true
end
