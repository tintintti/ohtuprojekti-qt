require 'test_helper'

class ReputationPostTopicsControllerTest < ActionController::TestCase
  setup do
    @reputation_post_topic = reputation_post_topics(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:reputation_post_topics)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create reputation_post_topic" do
    assert_difference('ReputationPostTopic.count') do
      post :create, reputation_post_topic: { postcount: @reputation_post_topic.postcount, reputation: @reputation_post_topic.reputation, tid: @reputation_post_topic.tid }
    end

    assert_redirected_to reputation_post_topic_path(assigns(:reputation_post_topic))
  end

  test "should show reputation_post_topic" do
    get :show, id: @reputation_post_topic
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @reputation_post_topic
    assert_response :success
  end

  test "should update reputation_post_topic" do
    patch :update, id: @reputation_post_topic, reputation_post_topic: { postcount: @reputation_post_topic.postcount, reputation: @reputation_post_topic.reputation, tid: @reputation_post_topic.tid }
    assert_redirected_to reputation_post_topic_path(assigns(:reputation_post_topic))
  end

  test "should destroy reputation_post_topic" do
    assert_difference('ReputationPostTopic.count', -1) do
      delete :destroy, id: @reputation_post_topic
    end

    assert_redirected_to reputation_post_topics_path
  end
end
