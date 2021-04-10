require 'rails_helper'

RSpec.describe "ユーザー新規登録機能", type: :system do
   before do
    @user = FactoryBot.build(:user)
   end

  context '新規登録できるとき' do
    it '正しい情報を入力すればユーザー新規登録ができ、トップページへ移動する' do
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'user_nickname', with: @user.nickname
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      fill_in 'user_password_confirmation', with: @user.password_confirmation
      # サインアップボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect {
        click_on('Sign up')
      }. to change { User.count }.by(1)
      # トップページへ遷移することを確認する
      expect(current_path).to eq(root_path)
    end
  end

  context '新規登録できないとき' do
    it '誤った情報ではユーザー新規登録ができず、新規登録ページに戻る' do
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'user_nickname', with: ''
      fill_in 'user_email', with: ''
      fill_in 'user_password', with: ''
      fill_in 'user_password_confirmation', with: ''
      # サインアップボタンを押してもユーザーモデルのカウントが変わらないことを確認する
      expect {
        click_on('Sign up')
      }. to change { User.count }.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq('/users')
    end
  end
end

RSpec.describe "ユーザーログイン機能", type: :system do
  before do
    @user = FactoryBot.create(:user)
  end

  context 'ログインできるとき' do
    it 'ログインに成功し、トップページに遷移する' do
      # サインインページへ移動する
      visit new_user_session_path
      # ログインしていない場合、サインインページに遷移していることを確認する
      expect(current_path).to eq(new_user_session_path)
      # すでに保存されているユーザーのemailとpasswordを入力する
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      # ログインボタンをクリックする
      click_on('Log in')
      # トップページに遷移していることを確認する
      expect(current_path).to eq(root_path)
    end
  end

  context 'ログインできないとき' do
    it 'ログインしていない状態でトップページにアクセスした場合、サインインページに移動する' do
      # トップページに遷移する
      visit root_path
      # ログインしていない場合、サインインページに遷移していることを確認する
      expect(current_path).to eq(new_user_session_path)
    end

    it 'ログインに失敗し、再びサインインページに戻ってくる' do
      # 予め、ユーザーをDBに保存する
      @user = FactoryBot.create(:user)
      # トップページに遷移する
      visit root_path
      # ログインしていない場合、サインインページに遷移していることを確認する
      expect(current_path).to eq(new_user_session_path)
      # 誤ったユーザー情報を入力する
      fill_in 'user_email', with: ''
      fill_in 'user_password', with: ''
      # ログインボタンをクリックする
      click_on('Log in')
      # サインインページに戻ってきていることを確認する
      expect(current_path).to eq(new_user_session_path)
    end
  end
end
