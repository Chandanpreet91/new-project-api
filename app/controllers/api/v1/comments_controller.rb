class Api::V1::CommentsController < ApplicationController
    def create
        @blog = Blog.find params[:blog_id]
        @comment = Comment.new params.require(:comment).permit(:body)
        @comment.blog = @blog
        @comment.user= current_user
        if comment.save
            render(json: @comment)
        else
            render(
                json: { errors: user.errors },
                status: 422
            )
        end

        def destroy
            @comment = Comment.find params[:id]
            @comment.destroy
            render(json: {errors: @comment.errors}, status:200)
        end
end
