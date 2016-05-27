require 'rails_helper'

include DatabaseHelpers

RSpec.describe Topic, type: :model do
  describe "topic" do
    it 'is created correctly with correct parameters' do
      params = DatabaseHelpers.get_topic
      topic = Topic.create(
        tid:params["tid"],
        uid:params["uid"],
        cid:params["cid"],
        mainPid:params["mainPid"],
        title:params["title"],
        slug:params["slug"],
        timestamp:params["timestamp"],
        lastposttime:params["lastposttime"],
        postcount:params["postcount"],
        viewcount:params["viewcount"],
        locked:params["locked"],
        pinned:params["pinned"],
        isQuestion:params["isQuestion"],
        isSolved:params["isSolved"],
        relativeTime:params["relativeTime"],
        lastposttimeISO:params["lastposttimeISO"],
      )

      expect(topic).to be_valid
      expect(topic.tid).to eq(67471)
      expect(topic.uid).to eq(20121)
      expect(topic.cid).to eq(10)
      expect(topic.mainPid).to eq(329490)
      expect(topic.title).to eq("will the items pointer changed after QList::RemoveAt(i)?")
      expect(topic.slug).to eq("67471/will-the-items-pointer-changed-after-qlist-removeat-i")
      expect(topic.timestamp).to eq("1464159358372")
      expect(topic.lastposttime).to eq("1464161740934")
      expect(topic.postcount).to eq(3)
      expect(topic.viewcount).to eq(9)
      expect(topic.locked).to eq(false)
      expect(topic.pinned).to eq(false)
      expect(topic.isQuestion).to eq(1)
      expect(topic.isSolved).to eq(0)
      expect(topic.relativeTime).to eq("2016-05-25T06:55:58.372Z")
      expect(topic.lastposttimeISO).to eq("2016-05-25T07:35:40.934Z")

    end

    it 'validates correctly by user id' do
      Topic.create tid:2
      Topic.create tid:2
      expect(Topic.all.count).to eq(1)
    end

    it 'isnt created without user id' do
      topic = Topic.create cid:10
      expect(topic).not_to be_valid
      expect(Topic.count).to eq(0)
    end
  end
end
