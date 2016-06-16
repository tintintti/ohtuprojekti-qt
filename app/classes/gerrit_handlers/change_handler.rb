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

  def self.average_time
    times = time_to_pass
    sum = 0
    times.each do |hash|
      sum += hash[:time]
    end
    sum = sum / times.length
  end

  def self.average_revisions
    revisions = revisions_needed_to_pass
    sum = 0
    revisions.each do |hash|
      sum += hash[:revisions]
    end
    sum = sum /revisions.length
  end

  def self.print_formatted(time)
    mm, ss = time.divmod(60)
    hh, mm = mm.divmod(60)
    dd, hh = hh.divmod(24)
    puts "#{dd} days, #{hh} hours, #{mm} minutes and #{ss.round} seconds"
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
