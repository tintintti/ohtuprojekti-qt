require 'rails_helper'

RSpec.describe "topics/edit", type: :view do
  before(:each) do
    @topic = assign(:topic, Topic.create!(
      :tid => 1,
      :uid => 1,
      :cid => 1,
      :mainPid => 1,
      :title => "MyString",
      :slug => "MyString",
      :timestamp => 1,
      :lastposttime => 1,
      :postcount => 1,
      :viewcount => 1,
      :locked => false,
      :pinned => false,
      :isQuestion => 1,
      :isSolved => 1,
      :relativeTime => "MyString",
      :lastposttimeISO => "MyString"
    ))
  end

  it "renders the edit topic form" do
    render

    assert_select "form[action=?][method=?]", topic_path(@topic), "post" do

      assert_select "input#topic_tid[name=?]", "topic[tid]"

      assert_select "input#topic_uid[name=?]", "topic[uid]"

      assert_select "input#topic_cid[name=?]", "topic[cid]"

      assert_select "input#topic_mainPid[name=?]", "topic[mainPid]"

      assert_select "input#topic_title[name=?]", "topic[title]"

      assert_select "input#topic_slug[name=?]", "topic[slug]"

      assert_select "input#topic_timestamp[name=?]", "topic[timestamp]"

      assert_select "input#topic_lastposttime[name=?]", "topic[lastposttime]"

      assert_select "input#topic_postcount[name=?]", "topic[postcount]"

      assert_select "input#topic_viewcount[name=?]", "topic[viewcount]"

      assert_select "input#topic_locked[name=?]", "topic[locked]"

      assert_select "input#topic_pinned[name=?]", "topic[pinned]"

      assert_select "input#topic_isQuestion[name=?]", "topic[isQuestion]"

      assert_select "input#topic_isSolved[name=?]", "topic[isSolved]"

      assert_select "input#topic_relativeTime[name=?]", "topic[relativeTime]"

      assert_select "input#topic_lastposttimeISO[name=?]", "topic[lastposttimeISO]"
    end
  end
end
