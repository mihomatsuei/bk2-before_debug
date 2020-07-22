class BooksController < ApplicationController

  def index
    # @book = Book.newを追加
    @books = Book.all
    @book = Book.new
    @user = current_user
    # @post_comments = PostComment.where(book_id: @book.id)は定義しなくてOK
  end

  def create
    @user = current_user
    @books = Book.all
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id), notice: "You have created book successfully."
    else
      render 'index'
    end
  end

  def show
    # ブラウザのurlと同じidのbookのデータが欲しい@find_book=データを持ったbook
    @find_book = Book.find(params[:id])
    # @book=データを持っていない空のbook
    @book = Book.new
    # データを持ったbookのユーザー
    @user = @find_book.user
    @post_comment = PostComment.new
    # 与えられた条件にマッチするレコードをすべて返す
    # ポストコメントモデルに入っている中でbook_idが一緒のものをとってきたい
    @post_comments = PostComment.where(book_id: @find_book.id)
  end

  def edit
    @book = Book.find(params[:id])
    @user = @book.user
    if @user == current_user
    else
       redirect_to books_path #bookindexへ
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

# delete→destroyへ
  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path, notice: "successfully delete book!"
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
