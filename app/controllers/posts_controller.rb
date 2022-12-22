class PostsController < ApplicationController
  def index
    @posts = Post.by_creation_date_desc
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    category = Category.find(post_params[:category_id])
    user = User.find(current_user[:id])
    @post.category = category
    @post.user = user

    if @post.save
      redirect_to @post, notice: 'Post created'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to @post, notice: 'Post updated'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])

    @post.destroy
    redirect_to posts_url, notice: 'Post deleted'
  end

  private

  def post_params
    params.require(:post).permit(:category_id, :body, :title, :user_id)
  end
end
