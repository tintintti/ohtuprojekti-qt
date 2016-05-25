class WelcomeController < ApplicationController
  def index
  end

  def view
    @postcounts = UserHandler.user_postcounts
  end

  def user_postcounts_cut_with(n)
    arr = Array.new
    users = User.all

    # lowPostCount = 0

    users.each do |user|

      # if (user.postcount < n)
      #   lowPostCount += 1
      #   next
      # end

      entry = { "label" => user.username, "postcount" => user.postcount }

      arr.push(entry)
    end
    # entry = { "label" => "users with < #{n} posts", "postcount" => lowPostCount }
    # arr.push(entry)
    arr
  end

end
