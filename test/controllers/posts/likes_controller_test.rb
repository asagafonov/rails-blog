# frozen_string_literal: true

require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)

    @post2 = posts(:two)
    @like = post_likes(:deletable)
    @user = users(:one)

    sign_in @user
  end

  test 'should create like' do
    post post_likes_url(@post)

    like = PostLike.find_by(post_id: @post.id, user_id: @user.id)

    assert { like }

    assert_redirected_to post_url(@post)
  end

  test 'should destroy like' do
    delete post_like_url(@post2, @like)

    assert { !PostLike.exists?(@like.id) }

    assert_redirected_to post_url(@post2)
  end
end
