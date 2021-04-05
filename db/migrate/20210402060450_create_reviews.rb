class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.text     :summary
      t.text     :impressions
      t.text     :plan
      t.references :book
      t.references :user,   foreign_key: true
      t.timestamps
    end
    add_foreign_key :reviews, :books, colum: :isbn, primary_key: :isbn
  end
end
