class BookCommentsController < ApplicationController
  def create
    @book_comment = BookComment.new(
      book_id: params[:book_id],
      user_id: current_user.id,
      body: params[:book_comment][:body]
    )
    if @book_comment.save
      flash[:notice] = "コメントの投稿が完了しました"
      redirect_to book_path(params[:book_id])
    else
      @book = Book.find(params[:book_id])
      @user = @book.user
      render "books/show"
    end
  end
  
  def destroy
    book_comment = BookComment.find(params[:id])
    book_comment.destroy
    redirect_to book_path(params[:book_id])
  end
  
  def book_comment_params
    params.require(:book_comment).permit(:body)
  end
end
