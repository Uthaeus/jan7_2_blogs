class BlogsController < ApplicationController

  def index
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(params.require(:blog).permit(:title, :date, :body))

    @blog.save

    redirect_to @blog
  end

  def show
    @blog = Blog.find(params[:id])
  end

end
