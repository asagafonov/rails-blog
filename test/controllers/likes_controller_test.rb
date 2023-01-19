# frozen_string_literal: true

require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)

    @post2 = posts(:two)
    @like = post_likes(:deletable)

    sign_in users(:one)
  end

  test 'should create like once' do
    assert_difference('PostLike.count') do
      post post_likes_url(@post)
    end

    assert_no_difference('PostLike.count') do
      post post_likes_url(@post)
    end

    assert_redirected_to post_url(@post)
  end

  test 'should destroy like' do
    assert_difference('PostLike.count', -1) do
      delete post_like_url(@post2, @like)
    end

    assert_redirected_to post_url(@post2)
  end
end
