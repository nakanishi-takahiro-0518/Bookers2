class BookCommentsController < ApplicationController
    before_action :authenticate_user!
    def create
        @comment = current_user.book_comments.new(comment_params)
        @comment.book_id = params[:book_id]
        @comment.save
    end

    def destroy
        @comment = BookComment.find(params[:id])
        if @comment.user == current_user
        @comment.destroy
        else
        redirect_to user_path(current_user)
        end
    end

    private
    def comment_params
        params.require(:book_comment).permit(:body)
    end
end
