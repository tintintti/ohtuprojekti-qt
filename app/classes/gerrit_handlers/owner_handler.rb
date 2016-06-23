class OwnerHandler

  def self.changes_by_owner
      owners = GerritOwner.all

      data = []
      owners.each do |owner|
        data << {label: owner.name, value: owner.gerrit_changes.length}
      end
      sorted_data = data.sort_by { |item| item[:value] }
  end

  def self.owner_domains

    changes_owners = GerritChange.all.pluck(:gerrit_owner_id)
    owners = GerritOwner.find(changes_owners)

    if owners.empty?
      return owners
    end
    domains = {}

    owners.each do |owner|
      if owner.email != nil
      email = owner.email
        if email.split("@")[1] != nil
          email = email.split("@")[1].split(".")[0]
          if !domains.key? email
            domains[email] = {label:email, value:0}
          end
          domains[email][:value] += 1
        end
      end
    end

    data = []
    domains.each_value { |value| data << value }
    data
  end

end
