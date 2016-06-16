class GitHandler
  def self.author_commits(time, amount)
    timeFrame = "stamp > " + time.to_s
    data = []
    authors = Author.all.sort_by{|a| (a.commits.where(timeFrame).count || 0)}.last(amount)
    authors.each do |author|
      label = author.name
      value = author.commits.where(timeFrame).count #+  " " + author.email
      if (value > 0)
        data << {label: label, value: value}
      end
    end
    data
  end

  def self.author_emails()
    data = []
    authors = Author.all
    emails = {}
    authors.each do |author|
      if author.email != nil && author.email.include?("@") || author.email.include?(" at ")
        puts "asdsd" + author.email
        email = author.email.split(" at ").join("@").split(" ").join(".")
        puts "asd " + email
        email = email.split("@")[1].split(".")[0]
      end
      if !emails.key? email
         emails[email] = 0
      end
      emails[email] += 1
    end
    # emails = emails.sort_by {|e| e[:value]}
    emails.each do |email, count|
      data << {label: email, value: count}
    end
    data.sort {|a, b| a[:value] <=> b[:value]}
  end
end

#
# emailData = []
# emails = emails.sort_by {|e| e[:value]}
# emails.each_value do {|value| emailData << value}
# emailData = emailData.sort_by {|item| item[:value]}
