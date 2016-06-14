FactoryGirl.define do
  factory :topic do
    tid 1
    uid 1
    cid 1
    mainPid 1
    title "Topic1"
    slug "topic1"
    timestamp "timestamp"
    lastposttime "time"
    postcount 1
    viewcount 1
    locked false
    pinned false
    isQuestion 1
    isSolved 1
    relativeTime "time"
    lastposttimeISO "time"
  end
  factory :topic2, class: Topic do
    tid 2
    uid 2
    cid 1
    mainPid 1
    title "Topic2"
    slug "topic2"
    timestamp "timestamp"
    lastposttime "time"
    postcount 1
    viewcount 1
    locked false
    pinned false
    isQuestion 1
    isSolved 1
    relativeTime "time"
    lastposttimeISO "time"
  end
  factory :topic_no_user, class: Topic do
    tid 3
    uid 5
    cid 1
    mainPid 1
    title "Topic2"
    slug "topic2"
    timestamp "timestamp"
    lastposttime "time"
    postcount 1
    viewcount 1
    locked false
    pinned false
    isQuestion 1
    isSolved 1
    relativeTime "time"
    lastposttimeISO "time"
  end
end
