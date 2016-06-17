class ChangeHandler

  def self.change_data
    {times: time_to_pass, revisions: revisions_needed_to_pass}
  end

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
      times << {label: change.id, value: difference.round}
    end
    times
  end

  def self.averages
    averages = {time: average_time, revisions: average_revisions}
  end

  def self.average_time
    times = time_to_pass
    if average(times) != nil
      average(times).round
    end
  end

  def self.average_revisions
    revisions = revisions_needed_to_pass
    average(revisions)
  end

  def self.average(data)
    if data.length > 0
    sum = 0
      data.each do |hash|
        sum += hash[:value]
      end
    sum = sum /data.length
    end
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
      changes << {label: change.id, value: revisions}
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
