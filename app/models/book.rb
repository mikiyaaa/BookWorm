class Book < ApplicationRecord
  with_options presence: true do
    validates :isbn, numericality: {only_integer: true}, length: { in: 10..13 }
    validates :title
    validates :author
    validates :caption
    validates :url
  end


  self.primary_key = "isbn"
  has_one :review, dependent: :destroy
  belongs_to :user
end
