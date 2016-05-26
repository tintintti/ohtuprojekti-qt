# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Post.create(pid: 329292, uid: 28465, tid: 67429, content: "<p>I tried to install qt 5.6 on raspberry usnig th...", timestamp: "1464087423887", reputation: 0, votes: 0, edited: "0", deleted: false, index: 0)
User.create(username: "madababi", userslug: "madababi", email: "mdababi1989@gmail.com", picture: "https://www.gravatar.com/avatar/628b4d63dc66543193...", fullname: "", signature: "", reputation: 0, postcount: 6, banned: false, status: "online", uid: 28465, lastonline: "1464088893523")
Topic.create(tid: 67546, uid: 29085, cid: 10, mainPid: 329875, title: "QSqlTableModel rowCount doesn&#x27;t change after ...", slug: "67546/qsqltablemodel-rowcount-doesn-t-change-after...", timestamp: "1464277481075", lastposttime: "1464277481089", postcount: 1, viewcount: 3, locked: false, pinned: false, isQuestion: 1, isSolved: 0, relativeTime: "2016-05-26T15:44:41.075Z", lastposttimeISO: nil )
