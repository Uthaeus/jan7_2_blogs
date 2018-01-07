class BlogsController < ApplicationController
  before_action :set_blog, only: [:show]

  def index
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



  private

    def blog_params
      params.require(:blog).permit(:title, :date, :body)
    end

    def set_blog
      @blog = Blog.find(params[:id])
    end

end
