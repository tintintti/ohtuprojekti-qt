class ParseGerritData

  @downloader = GerritDownloader.new

  def self.download_details
    changes = @downloader.n_changes(2)
    details = OwnerHandler.fetch_details(changes)
  end

  def self.fetch_and_save_changes_data(n)
    changes = @downloader.n_changes(n)
    details = OwnerHandler.fetch_details(changes)
    self.parse_all(details)
  end

  def self.fetch_and_save_merged_changes(n)
    changes = @downloader.n_changes_with_status(n, 'merged')
    details = OwnerHandler.fetch_details(changes)
    self.parse_all(details)
  end

  def self.parse_all(changes)

    changes.each do |current|
      owner = self.create_owner(current['owner'])
      if owner.id.nil?
        owner = GerritOwner.find_by account_id: current['owner']['_account_id']
      end

      change = self.create_change(current, owner.id)

      if change.id.nil?
        change = GerritChange.find_by id_from_gerrit: current['id']
      end

      if current['messages']
        current['messages'].each do |message|
          self.create_message(message, change.id)
        end
      end

      if current['labels']['Code-Review']
        current['labels']['Code-Review']['all'].each do |codereview|
          self.create_code_review(codereview, change)
        end
      end

      if current['labels']['Sanity-Review']
        current['labels']['Sanity-Review']['all'].each do |sanityreview|
          self.create_sanity_review(sanityreview, change)
        end
      end
    end
  end

  def self.create_owner(change_owner)
    GerritOwner.create(account_id:change_owner['_account_id'], name:change_owner['name'], email:change_owner['email'])
  end

  def self.create_change(change, gerrit_owner_id)
    GerritChange.create(kind:change['kind'], id_from_gerrit:change['id'], project:change['project'],
                  branch:change['branch'], change_id:change['id'], subject:change['subject'], status:change['status'],
                  created:change['created'], updated:change['updated'],
                  mergeable:change['mergeable'], sortkey:change['_sortkey'],
                  number:change['_number'], gerrit_owner_id:gerrit_owner_id)
  end

  def self.create_message(message, change_id)
    authorId = 0

    if message['author']
      author = self.create_owner(message['author'])
      if author.id.nil?
        author = GerritOwner.find_by account_id: message['author']['_account_id']
      end
      authorId = author.id
    end

    GerritMessage.create(message_id:message['id'], date:message['date'],
                    message:message['message'], gerrit_owner_id:authorId,
                    revision_number:message['_revision_number'], gerrit_change_id:change_id)
  end

  def self.create_code_review(review, change)
    author = self.create_owner(review)
    if author.id.nil?
      author = GerritOwner.find_by account_id: review['_account_id']
    end
    GerritCodeReview.create(value:review['value'], change_id_from_gerrit:change.id_from_gerrit,
                      gerrit_change_id:change.id, gerrit_owner_id:author.id)
  end

  def self.create_sanity_review(review, change)
    author = self.create_owner(review)
    if author.id.nil?
      author = GerritOwner.find_by account_id: review['_account_id']
    end
    GerritSanityReview.create(value:review['value'], change_id_from_gerrit:change.id_from_gerrit,
                      gerrit_change_id:change.id, gerrit_owner_id:author.id)
  end

end
