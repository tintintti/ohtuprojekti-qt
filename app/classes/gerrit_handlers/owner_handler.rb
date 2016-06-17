class OwnerHandler
  @downloader = GerritDownloader.new

  def self.changes_by_owner
      owners = GerritOwner.all

      data = []
      owners.each do |owner|
        data << {label: owner.name, value: owner.gerrit_changes.length}
      end
      sorted_data = data.sort_by { |item| item[:value] }
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

  def self.owner_domains
    owners = GerritOwner.all
    if owners.empty?
      return owners
    end
    domains = {}

    owners.each do |owner|
      email = owner.email
      email = email.split("@")[1].split(".")[0]
      if !domains.key? email
        domains[email] = {label:email, value:0}
      end
      domains[email][:value] += 1
    end

    data = []
    domains.each_value { |value| data << value }
    data
  end

end
