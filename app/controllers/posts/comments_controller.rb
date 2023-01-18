# frozen_string_literal: true

module Posts
  class CommentsController < ApplicationController
    def index
      @post = set_post
    end

    def new
      @post = set_post
    end

    def create
      @post = set_post
      @comment = @post.comments.build(comment_params)
      @comment.ancestry = params[:ancestry]
      @comment.user = current_user

      if @comment.save
        redirect_to post_path(@post), notice: t('notifications.comments.created.success')
      else
        redirect_to post_path(@post), alert: t('notifications.comments.created.failure')
      end
    end

    def edit
      @comment = set_comment
    end

    def update
      @comment = set_comment

      if @comment.update(comment_params)
        redirect_to post_url(@comment[:post_id]), notice: t('notifications.comments.updated')
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @comment = set_comment

      if belongs_to_user(@comment)
        @comment.destroy
        redirect_to post_url(@comment[:post_id]), notice: t('notifications.comments.deleted')
      else
        redirect_to post_url(@comment[:post_id]), alert: t('notifications.comments.forbidden.delete')
      end
    end

    private

    def belongs_to_user(comment)
      comment.user.email == current_user.email
    end

    def set_post
      @post = Post.find(params[:post_id])
    end

    def set_comment
      @comment = PostComment.find(params[:id])
    end

    def comment_params
      params.require(:post_comment).permit(:content, :post_id)
    end
  end
end
