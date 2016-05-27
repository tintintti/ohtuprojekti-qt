require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "post" do
    it 'is created correctly with correct parameters' do
      params = DatabaseHelpers.get_posts
      post = Post.create(
          pid:params["pid"],
          uid:params["uid"],
          tid:params["tid"],
          content:params["content"],
          timestamp:params["timestamp"],
          reputation:params["reputation"],
          votes:params["votes"],
          edited:params["edited"],
          deleted:params["deleted"],
          index:params["index"]
      )

      expect(post).to be_valid
      expect(post.pid).to eq(329490)
      expect(post.uid).to eq(20121)
      expect(post.tid).to eq(67471)
      expect(post.content).to eq("<p>how QList store data in memory? like list or array?<br />\nthank you!</p>\n")
      expect(post.timestamp).to eq("1464159358385")
      expect(post.reputation).to eq(0)
      expect(post.votes).to eq(0)
      expect(post.edited).to eq("0")
      expect(post.deleted).to eq(false)
      expect(post.index).to eq(0)
    end
  end

  it 'validates correctly by post id' do
    Post.create pid:2
    Post.create pid:2
    expect(Post.all.count).to eq(1)
  end

  it 'isnt created without post id' do
    post = Post.create content:"lol"
    expect(post).not_to be_valid
    expect(Post.count).to eq(0)
  end
end
