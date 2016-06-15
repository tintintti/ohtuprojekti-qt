class ChangeHandler

  # time it took each change to pass in seconds
  def self.time_to_pass
    passed = passed_reviews
    times = []
    passed.each do |pass|
      change     = pass[0]
      message    = pass[1]
      created    = Time.parse(change.created)
      accepted   = Time.parse(message.date)
      difference = accepted - created
      times << {change: change.id, time: difference}
    end
    times
  end

  def self.revisions_needed_to_pass
    passed = passed_reviews
    changes = []
    passed.each do |pass|
      change = pass[0]
      revisions = pass[1].revision_number
      changes << {change: change.id, revisions: revisions}
    end
    changes
  end

  def self.passed_reviews
    merged = GerritChange.where(status: "MERGED")
    passed = []
    merged.each do |change|
      messages = change.gerrit_messages
      messages.each do |message|
        if message.message.include? "Continuous Integration: Passed"
          passed << [change, message]
          break
        end
      end
    end
    passed
  end

end
