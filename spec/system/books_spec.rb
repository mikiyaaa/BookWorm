require 'rails_helper'

RSpec.describe "書籍登録機能", type: :system do
  before do
    @user = FactoryBot.create(:user)
  end

  context '書籍登録に成功するとき' do
    it 'ログインしたユーザーは書籍登録ができる' do
      # サインインする
      sign_in(@user)
      # 書籍登録ページへのリンクがあることを確認する
      expect(page).to have_content('書籍を追加する')
      # 書籍登録ページへ移動する
      visit new_book_path
      # 検索フォームに情報を入力する
      fill_in 'title', with: '20代を無難に生きるな'
      # 検索をクリックすると該当の書籍が一覧表示されることを確認する
        click_on('書籍を検索')
        expect(page).to have_content('20代を無難に生きるな')
      # 登録するとBookモデルのカウントが1上がることを確認する
      expect{
        click_on('登録する')
    }.to change { Book.count }.by(1)
      # トップページへ遷移することを確認する
      expect(current_path).to eq(root_path)
      # トップページに登録した書籍が存在することを確認する
      expect(page).to have_content('20代を無難に生きるな')
    end
  end

  context '書籍が登録できないとき' do
    it '既にデータベースに登録されている書籍は登録できない' do
        # サインインする
        sign_in(@user)
        # 書籍登録ページへのリンクがあることを確認する
        expect(page).to have_content('書籍を追加する')
        # 書籍登録ページへ移動する
        visit new_book_path
        # 検索フォームに情報を入力する
        fill_in 'title', with: '20代を無難に生きるな'
        # 検索をクリックすると該当の書籍が一覧表示されることを確認する
          click_on('書籍を検索')
          expect(page).to have_content('20代を無難に生きるな')
        # 登録するとBookモデルのカウントが1上がることを確認する
        expect{
          click_on('登録する')
      }.to change { Book.count }.by(1)
        # トップページへ遷移することを確認する
        expect(current_path).to eq(root_path)
        # トップページに登録した書籍が存在することを確認する
        expect(page).to have_content('20代を無難に生きるな')
        # 書籍登録ページへ移動する
        visit  new_book_path
        # 検索フォームに情報を入力する
        fill_in 'title', with: '20代を無難に生きるな'
        # 検索をクリックすると該当の書籍が一覧表示されることを確認する
        click_on('書籍を検索')
        expect(page).to have_content('20代を無難に生きるな')
        # 登録してもBookモデルのカウントは変わらないことを確認する
        expect{
          click_on('登録する')
      }.to change { Book.count }.by(0)
        # 書籍登録ページへ戻っていることを確認する
        expect(current_path).to eq('/books')
    end
  end

  
end
