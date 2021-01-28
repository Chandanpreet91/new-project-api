class Api::V1::BlogsController < ApplicationController
    before_action :find_blog, only: [:show,:update, :destroy]

  def index
    blogs = Blog.order(created_at: :desc)
    
  end

  def show
    @blog = Blog.find(params[:id])
    render(json: @blog)
  end

  def create
    blog = Blog.new blog_params
    blog.user = current_user
    if blog.save
      render json: { id: blog.id }
    else
      render(
        json: { errors: blog.errors },
        status: 422 # unprocessable entity HTTP Code
      )
    end
  end
  def update
    if @blog.update blog_params
      render json: {id: @blog.id}
    else
      render(
      json:{ errors: @blog.errors},
      status: 422)

    end
  end

  def destroy
    @blog.destroy
    render(json: {errors: @blog.errors}, status:200)
  end

  private
    def find_blog
        @blog||=Blog.find params[:id]
    end
  
    def blog_params
        params.require(:blog).permit(:title, :description)
    end

end
