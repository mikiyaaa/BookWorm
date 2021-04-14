class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_review, except: :update
  before_action :move_to_index, except: :update

  def index
    @review = @book.review
  end

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    if @review.save
      redirect_to action: :index
    else
      render action: :new
    end
  end

  def edit
    @review = @book.review
  end

  def update
    book = Book.find(params[:book_id])
    review = book.review
    if review.update(review_params)
      redirect_to action: :index
    else
      render action: :new
    end
  end

  private
  def review_params
    params.require(:review).permit(:summary, :impressions, :plan).merge(user_id: current_user.id, book_id: params[:book_id])
  end

  def set_review
    @book = Book.find(params[:book_id])
  end

  def move_to_index
    if current_user.id != @book.user_id
      redirect_to books_path
    end
  end
end
