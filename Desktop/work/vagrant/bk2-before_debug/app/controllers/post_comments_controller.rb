class PostCommentsController < ApplicationController

   def create
    @comment = current_user.post_comments.new(post_comment_params)
     # @commentの中に入っているbook_id
    @comment.book_id = params[:post_comment][:book_id]
    @comment.save
    # 投稿後そのままbook detail(book#showのまま)
    redirect_to book_path(params[:post_comment][:book_id])
   end

   def destroy
   PostComment.find(params[:id]).destroy
   	# 削除後そのままbook detail(book#showのまま)
    redirect_back(fallback_location: books_path)
   end

   private
   def post_comment_params
    params.require(:post_comment).permit(:comment)
   end
end
