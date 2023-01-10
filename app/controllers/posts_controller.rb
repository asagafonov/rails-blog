# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_post, only: %i[show edit update destroy]

  def index
    @posts = Post.by_creation_date_desc
  end

  def show
    @comments = @post.comments.by_creation_date_desc
    @comment = @post.comments.build

    @like = @post.likes.find { |like| like.user_id == current_user&.id }
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to @post, notice: t('notifications.posts.created.success')
    else
      redirect_to posts_url, alert: t('notifications.posts.created.failure')
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: t('notifications.posts.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_url, notice: t('notifications.posts.deleted')
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:category_id, :body, :title)
  end

  def comment_params
    params.permit(:body, :post_id)
  end
end
