class GerritData < ActiveJob::Base
  queue_as :default

  def perform
    @owners = OwnerHandler.changes_by_owner
    Rails.cache.write "owners_data", @owners
    Rails.cache.write "downloading", false
  end

end
