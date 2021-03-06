class BooksController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @books = Book.where(user_id: current_user.id)
  end

  def new
    @books = []
    @title = params[:title]
    if @title.present?
      results = RakutenWebService::Books::Book.search({
        title: @title
      })

      results.each do |result|
        book = Book.new(read(result))
        @books << book
      end
    end
  end

  def create
    @book = Book.find_or_initialize_by(isbn: params[:isbn])
    unless @book.persisted?
      result = RakutenWebService::Books::Book.search(isbn: @book.isbn)
      @book = Book.new(read(result.first))
      if current_user.id == @book.user_id
        if @book.save
          redirect_to books_path
        else
          render action: :new
        end
      else
        redirect_to action: :index
      end
    else
      render action: :new
    end
  end

  def destroy
    book = Book.find(params[:id])
    if current_user.id == book.user_id
      book.destroy
      redirect_to books_path
    else
      redirect_to action: :index
    end
  end

  private
  def read(result)
    isbn = result["isbn"]
    title = result["title"]
    author = result["author"]
    caption = result["itemCaption"]
    image_url = result["mediumImageUrl"].gsub('?_ex=120x120', '')
    url = result["itemUrl"]
    {
      isbn: isbn,
      title: title,
      author: author,
      caption: caption,
      image_url: image_url,
      url: url,
      user_id: current_user.id
    }
  end

end
