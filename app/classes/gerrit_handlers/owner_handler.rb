class OwnerHandler
  @downloader = GerritDownloader.new

  def self.changes_by_owner
      changes = @downloader.changes
      details = fetch_details(changes)

      data = []
      owners(details).each_value do |v|
        data << {label: v[:owner]['name'], value: v[:changes]}
      end
      sorted_data = data.sort_by { |item| item[:value] }
  end

  def self.owners(change_details)
    owners = {}
    change_details.each do |change|
      owner_id = change['owner']['_account_id']
      if !owners.key?(owner_id)
        owners[owner_id] = {owner: change['owner'], changes: 0}
      end
      owners[owner_id][:changes] += 1
    end
    owners
  end

  def self.fetch_details(changes)
    change_details = []

    changes.each do |change|
      details = @downloader.change(change['id'])
      if details != nil
        change_details << details
      end
    end
    change_details
  end

end
