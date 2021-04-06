require 'rails_helper'

RSpec.describe Review, type: :model do
  describe '#create' do
    before do
      @review = FactoryBot.build(:review)
    end

    context '保存できるとき' do
      it '全ての値が存在すれば保存できる' do
        expect(@review).to be_valid
      end

      it 'ユーザーと書籍に紐づいていれば保存できる' do
        @review.summary = ''
        @review.impressions = ''
        @review.plan = ''
        expect(@review).to be_valid 
      end
    end

    context '保存できないとき' do
      it 'ユーザーに紐づいていなければ保存できない' do
        @review.user = nil
        @review.valid?
        expect(@review.errors.full_messages).to include("User must exist")
      end

      it '書籍に紐づいていなければ保存できない' do
        @review.book = nil
        @review.valid?
        expect(@review.errors.full_messages).to include("Book must exist")
      end
    end
  end
end
