class GitHandler
  def self.author_commits
    data = []
    authors = Author.all.sort_by{|a| (a.commits.where("stamp > 1420070400").count || 0)}.last(100)
    authors.each do |author|
      data << {label: author.name, value: author.commits.where("stamp > 1420070400").count}
    end
    data
  end
end

      # def self.user_postcounts
      #   postcounts = []
      #   posts = Post.all
      #
      #   users = {}
      #   slugs = {}
      #   posts.each do |post|
      #     user = post.ret_user
      #     name = "removed user"
      #     if user != nil
      #       name = user.username
      #       slugs[user.username] = user.userslug
      #     end
      #     if !users.key? name
      #       users[name] = 0
      #     end
      #     users[name] += 1
      #   end
      #
      #   users.each do |key, value|
      #     postcounts << {label: key, value: value}
      #   end
      #   [postcounts, slugs]
      # end
