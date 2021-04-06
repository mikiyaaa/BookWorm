require 'rails_helper'

RSpec.describe Book, type: :model do
  describe '#create' do
    before do
      @book = FactoryBot.build(:book)
    end

    context '保存できるとき' do
      it '全ての値が存在すれば保存できること' do
        expect(@book).to be_valid
      end

      it '画像が存在しなくても保存できること' do
        @book.image_url = nil
        expect(@book).to be_valid
      end
    end

    context '保存できないとき' do
      it 'isbnコードが空では保存できないこと' do
        @book.isbn = ''
        @book.valid?
        expect(@book.errors.full_messages).to include("Isbn can't be blank")
      end

      it 'タイトルが空では登録できないこと' do
        @book.title = ''
        @book.valid?
        expect(@book.errors.full_messages).to include("Title can't be blank")
      end

      it '著者名が空では保存できないこと' do
        @book.author = ''
        @book.valid?
        expect(@book.errors.full_messages).to include("Author can't be blank")
      end

      it '説明文が空では保存できないこと' do
        @book.caption = ''
        @book.valid?
        expect(@book.errors.full_messages).to include("Caption can't be blank")
      end

      it 'URLが空では保存できないこと' do
        @book.url = ''
        @book.valid?
        expect(@book.errors.full_messages).to include("Url can't be blank")
      end

      it "ユーザーが紐付いていなければ投稿できない" do
        @book.user = nil
        @book.valid?
        expect(@book.errors.full_messages).to include("User must exist")
      end
    end
  end
end
