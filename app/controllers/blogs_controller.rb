class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]

  def index
    @blogs = Blog.all
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id

    if @blog.save
      redirect_to @blog, notice: 'Your blog was created successfully'
    else
      render :new
    end
  end

  def show 
  end

  def edit

  end

  def update
    if @blog.update(blog_params)
      redirect_to @blog, notice: "Your blog was updated successfully"
    else
      render :edit
    end
  end

  def destroy
    @blog.delete
    redirect_to blogs_path, notice: "Your blog was successfully removed"
  end



  private

    def blog_params
      params.require(:blog).permit(:title, :date, :body)
    end

    def set_blog
      @blog = Blog.find(params[:id])
    end

end
