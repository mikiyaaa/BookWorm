class Book < ApplicationRecord
  self.primary_key = "isbn"
  has_one :review, dependent: :destroy
  belongs_to :user
end
