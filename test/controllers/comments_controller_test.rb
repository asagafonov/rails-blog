# frozen_string_literal: true

require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)
    @comment = post_comments(:with_comments)
    @nested_comment = post_comments(:nested)
    @deep_nested_comment = post_comments(:deep_nested)

    authenticate_user users(:one)
  end

  test 'should create nested post comments' do
    assert_difference('PostComment.count', 3) do
      post post_comments_url(@post), params: { post_comment: { content: @comment.content, post_id: @comment.post_id } }
      post post_comments_url(@post), params: { post_comment: { content: @nested_comment.content, post_id: @nested_comment.post_id } }
      post post_comments_url(@post), params: { post_comment: { content: @deep_nested_comment.content, post_id: @deep_nested_comment.post_id } }
    end

    assert { @deep_nested_comment.ancestry == "#{@comment.id}/#{@nested_comment.id}" }

    assert_redirected_to post_url(@post)
  end

  test 'should destroy nested post comments' do
    # delete branch comment
    assert_difference('PostComment.count', - 1) do
      delete post_comment_url(@post, @deep_nested_comment)
    end

    # delete root comment (sibling is also destroyed)
    assert_difference('PostComment.count', -2) do
      delete post_comment_url(@post, @comment)
    end

    assert_redirected_to post_path(@post)
  end
end
