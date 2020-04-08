class BookCommentsController < ApplicationController
   def create
    @book_id = Book.find(params[:book_id])
    @book_comment = current_user.book_comments.new(book_comment_params)
    @book_comment.book_id = @book_id.id
    @book_comment.user_id = current_user.id
    if @book_comment.save
       redirect_to book_path(@book_id)
    else
       @book = Book.new
       @user = @book_id.user
       render template: "books/show"
    end
end

    def destroy
            book = Book.find(params[:book_id])
            book_comment = current_user.book_comments.find_by(book_id: book.id)
            book_comment.destroy
            redirect_to book_path(book)
    end

private
def book_comment_params
    params.require(:book_comment).permit(:comment,:book_id, :user_id)
end
end