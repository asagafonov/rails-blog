# frozen_string_literal: true

module Posts
  class LikesController < ApplicationController
    before_action :set_post
    before_action :set_like, only: :destroy

    def create
      @like = @post.likes.create(user_id: current_user.id) if not_liked_yet?

      redirect_to post_path(@post)
    end

    def destroy
      @like.destroy if already_liked?

      redirect_to post_path(@post)
    end

    private

    def set_post
      @post = Post.find(params[:post_id])
    end

    def set_like
      @like = @post.likes.find(params[:id])
    end

    def already_liked?
      PostLike.where(user_id: current_user.id, post_id: params[:post_id]).exists?
    end

    def not_liked_yet?
      !already_liked?
    end
  end
end
