class BookCommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    @book_comment_new = BookComment.new
    @book_comment = BookComment.new(
      book_id: params[:book_id],
      user_id: current_user.id,
      body: params[:book_comment][:body]
    )
    if @book_comment.save
      flash[:notice] = "コメントの投稿が完了しました"
    else
      @user = @book.user
      render "books/show"
    end
  end
  
  def destroy
    @book = Book.find(params[:book_id])
    book_comment = BookComment.find(params[:id])
    book_comment.destroy
  end
  
  def book_comment_params
    params.require(:book_comment).permit(:body)
  end
end
