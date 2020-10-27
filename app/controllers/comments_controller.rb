class CommentsController < ApplicationController
  before_action :set_blog

  def create
    @blog.comments.new(comment_params).save
    render :remote_js
  end

  def destroy
    @blog.comments.destroy(params[:id]) if current_user.id == @blog.comments.find(params[:id]).user_id
    render :remote_js
  end

  private

    def set_blog
      @blog = Blog.find_with_comments(params[:blog_id])
    end

    def comment_params
      params.require(:comment).permit(:body).merge(user_id: current_user.id)
    end
end
