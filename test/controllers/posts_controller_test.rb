# frozen_string_literal: true

require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:without_comments)
    @not_my_post = posts(:two)

    @attrs = {
      title: Faker::Lorem.sentence(word_count: 3),
      body: Faker::Lorem.paragraph,
      category_id: categories(:one).id
    }

    authenticate_user users(:one)

    follow_redirect!
    assert_response :success
  end

  test 'should get index' do
    get posts_url
    assert_response :success
  end

  test 'should get new' do
    get new_post_url
    assert_response :success
  end

  test 'should create post' do
    post posts_url, params: { post: @attrs }
    post = Post.find_by @attrs

    assert { post }
    assert_redirected_to post_url(post)
  end

  test 'should show post' do
    get post_url(@post)
    assert_response :success
  end

  test 'should get edit' do
    get edit_post_url(@post)
    assert_response :success
  end

  test 'should update post' do
    patch post_url(@post), params: { post: @attrs }

    @post.reload

    assert { @post.title == @attrs[:title] }
    assert_redirected_to post_url(@post)
  end

  test "should not update other person's post" do
    patch post_url(@not_my_post), params: { post: @attrs }

    assert_redirected_to posts_url
    refute { @not_my_post.title == @attrs[:title] }
  end

  test 'should destroy post' do
    delete post_url(@post)

    assert { !Post.exists?(@post.id) }
    assert_redirected_to posts_url
  end

  test 'should not allow post creation for unauthenticated users' do
    delete destroy_user_session_url

    post posts_url, params: { post: @attrs }
    post = Post.find_by @attrs

    refute { post }
    assert_redirected_to new_user_session_path
  end
end
