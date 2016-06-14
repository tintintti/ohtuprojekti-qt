class GitHandler
  def self.author_commits(time, amount)
    timeFrame = "stamp > " + time.to_s
    data = []
    authors = Author.all.sort_by{|a| (a.commits.where(timeFrame).count || 0)}.last(amount)
    authors.each do |author|
      label = author.name #+  " " + author.email
      data << {label: label, value: author.commits.where(timeFrame).count}
    end
    data
  end
end
