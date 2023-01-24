# frozen_string_literal: true

require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)
    @comment = post_comments(:with_comments)
    @nested_comment = post_comments(:nested)
    @deep_nested_comment = post_comments(:deep_nested)

    @attrs = { content: 'root comment' }
    @attrs_nested = { content: 'first sibling' }
    @attrs_deep_nested = { content: 'sibling of sibling' }

    @user = users(:one)
    sign_in @user
  end

  test 'should create nested post comments' do
    post post_comments_url(@post), params: { post_comment: @attrs }
    comment = PostComment.find_by(@attrs)

    post post_comments_url(@post), params: { post_comment: @attrs_nested.merge(parent_id: comment.id) }
    nested_comment = PostComment.find_by(@attrs_nested)

    post post_comments_url(@post), params: { post_comment: @attrs_deep_nested.merge(parent_id: nested_comment.id) }
    deep_nested_comment = PostComment.find_by(@attrs_deep_nested)

    assert { comment.user_id == @user.id }
    assert { comment && nested_comment && deep_nested_comment }
    assert { deep_nested_comment.ancestry == "#{comment.id}/#{nested_comment.id}" }
    assert_redirected_to post_url(@post)
  end

  test 'should destroy nested post comments' do
    delete post_comment_url(@post, @comment)

    assert { !PostComment.exists?(@comment.id) }
    assert { !PostComment.exists?(@nested_comment.id) }
    assert { !PostComment.exists?(@deep_nested_comment.id) }

    assert_redirected_to post_path(@post)
  end
end
