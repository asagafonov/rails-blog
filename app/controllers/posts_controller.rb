# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]

  def index
    @posts = Post.by_creation_date_desc
  end

  def show
    @post = set_post
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
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @post = set_post

    redirect_to @post, alert: t('notifications.posts.forbidden.edit') unless post_belongs_to_user?
  end

  def update
    @post = set_post

    unless current_user.posts.include?(@post)
      redirect_to posts_path, notice: t('notifications.posts.forbidden.edit') and return
    end

    if @post.update(post_params)
      redirect_to @post, notice: t('notifications.posts.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = set_post

    if post_belongs_to_user?
      @post.destroy
      redirect_to posts_url, notice: t('notifications.posts.deleted')
    else
      redirect_to @post, alert: t('notifications.posts.forbidden.delete')
    end
  end

  private

  def post_belongs_to_user?
    @post.user_id == current_user&.id
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:category_id, :body, :title)
  end
end
