class BooksController < ApplicationController
  def index
    @books = Book.includes(:user)
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
      if @book.save
        redirect_to root_path
      else
        render action: :new
      end
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
