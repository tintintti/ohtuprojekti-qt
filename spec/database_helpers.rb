require 'json'

module DatabaseHelpers

topic_string =
    '{"tid":67471,
  "uid":20121,
  "cid":10,
  "mainPid":329490,
  "title":"will the items pointer changed after QList::RemoveAt(i)?",
  "slug":"67471/will-the-items-pointer-changed-after-qlist-removeat-i",
  "timestamp":1464159358372,
  "lastposttime":1464161740934,
  "postcount":3,
  "viewcount":9,
  "locked":false,
  "deleted":false,
  "pinned":false,
  "isQuestion":1,
  "isSolved":0,
  "teaserPid":"329501",
  "relativeTime":"2016-05-25T06:55:58.372Z",
  "lastposttimeISO":"2016-05-25T07:35:40.934Z",

  "tags":[],
  "isFollowing":false,
  "bookmark":null,
  "unreplied":false,
  "related":[],

  "reputation:disabled":false,
  "downvote:disabled":false,
  "feeds:disableRSS":false,
  "rssFeedUrl":"/topic/67471.rss",

  "loggedIn":false,
  "relative_path":"",

    "bodyClass":"page-topic page-topic-67471 page-topic-will-the-items-pointer-changed-after-qlist-removeat-i"}
'

posts_string = '
      {"pid":329490,
      "uid":20121,
      "tid":67471,
      "content":"<p>how QList store data in memory? like list or array?<br />\nthank you!</p>\n",
      "timestamp":1464159358385,
      "reputation":0,
      "votes":0,
      "editor":null,
      "edited":0,
      "deleted":false,
      "relativeTime":"2016-05-25T06:55:58.385Z",
      "relativeEditTime":"",
      "index":0,
      "favourited":false,
      "upvoted":false,
      "downvoted":false,
      "selfPost":false,
      "display_moderator_tools":false,
      "display_move_tools":false}
'

category_string = '
      {"cid":10,
      "name":"General and Desktop",
      "description":"This is where all the desktop OS and general Qt questions belong.",
      "icon":"fa-laptop",
      "bgColor":"#80c342",
      "color":"#FFFFFF",
      "slug":"10/general-and-desktop",
      "parentCid":"4",
      "topic_count":34058,
      "post_count":173490,
      "disabled":false,
      "order":2,
      "link":"",
      "numRecentReplies":1,
      "class":"col-md-4 col-xs-12",
      "imageClass":"auto",
      "totalPostCount":173490,
      "totalTopicCount":34058,
      "descriptionParsed":"This is where all the desktop OS and general Qt questions belong."}
'

user_string = '
      {"username":"opengpu2",
      "userslug":"opengpu2",
      "email":"opengpu@foxmail.com",
      "picture":"https://www.gravatar.com/avatar/ecaf594601aaf2df692e91ab97bf51a1?size=192&d=mm",
      "fullname":"",
      "signature":"",
      "reputation":2,
      "postcount":419,
      "banned":false,
      "status":"offline",
      "uid":20121,
      "lastonline":1464159234766,
      "icon:text":"O",
      "icon:bgColor":"#3f51b5",
      "groups":[],
      "custom_profile_info":[]}'

@topic = JSON.parse(topic_string)
@post = JSON.parse(posts_string)
@user = JSON.parse(user_string)

  def self.get_topic
    return @topic
  end

  def self.get_posts
    return @post
  end

  def self.get_user
    return @user
  end
end
