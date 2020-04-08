class BooksController < ApplicationController

	before_action :authenticate_user!
    before_action :correct_user,   only: [:edit, :update,:destroy]

    def show
        @book = Book.new
		@book_id = Book.find(params[:id])
	    @user = @book_id.user
        @book_comment = BookComment.new
    end

    def create
    	@book = Book.new(book_params)
    	@book.user_id = current_user.id
		if @book.save
			redirect_to book_path(@book), notice: "Book was successfully created."
		else
            @user = current_user
		    @books = Book.all
			render :index
		end
	end

	def index
		@user = current_user
		@book = Book.new
		@books = Book.all
	end

    def edit
   	 @book = Book.find(params[:id])
    end

    def update
    	@book = Book.find(params[:id])
    	@book_id = Book.find(params[:id])
        @user = @book_id.user
        if @book.update(book_params)
        	redirect_to book_path(@book), notice: "Book was successfully updated."
		else
			render :edit
		end
	end

    def destroy
        book = Book.find(params[:id])
        if book.destroy
        redirect_to books_path
        end
    end

    def correct_user
	  @book_id = Book.find(params[:id])
      @user = @book_id.user
      redirect_to books_path unless @user == current_user
    end


	private
	def book_params
		params.require(:book).permit(:title,:body)
	end

end