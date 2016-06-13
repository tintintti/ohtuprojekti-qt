class GerritChange < ActiveRecord::Base
  validates :id_from_gerrit, uniqueness: true

  belongs_to :gerrit_owner
  has_many :gerrit_messages
  has_many :gerrit_sanity_reviews
  has_many :gerrit_code_reviews
end
