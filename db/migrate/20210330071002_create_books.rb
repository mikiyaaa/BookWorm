class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books, id: false do |t|
      t.bigint     :isbn,    primary_key: true
      t.string     :title,   null: false
      t.string     :author,  null: false
      t.text       :caption
      t.string     :image_url
      t.string     :url
      t.references :user,    foreign_key: true

      t.timestamps
    end
  end
end
