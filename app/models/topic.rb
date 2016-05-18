class Topic < ActiveRecord::Base
  validates :raw_json, uniqueness:true
end
