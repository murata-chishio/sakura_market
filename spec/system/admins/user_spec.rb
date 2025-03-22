RSpec.describe 'ユーザーのログイン機能', type: :system do
  let!(:admin) { create(:admin, email: 'admin@example.com', password: 'password123#') }

  before do
    sign_in(admin, scope: :admin)
  end

  describe 'ユーザーの編集' do
    before do
      create(:user, email: 'user@example.com', password: 'password123#')
    end

    it 'ユーザー情報を編集できること' do
      visit admins_users_path
      expect(page).to have_content 'user@example.com'
      click_on '編集'
      fill_in 'メールアドレス', with: 'change@example.com'
      fill_in 'パスワード', with: 'change123#', match: :first
      fill_in 'パスワード（確認用）', with: 'change123#'
      click_button '更新する'
      expect(page).to have_content '登録しました。'

      visit new_user_session_path
      fill_in 'メールアドレス', with: 'change@example.com'
      fill_in 'パスワード', with: 'change123#'
      click_button 'ログイン'
      expect(page).to have_content 'ログインしました。'
      expect(page).to have_content 'change@example.com'
    end
  end

  describe 'ユーザーの削除' do
    before do
      create(:user, email: 'user@example.com', password: 'password123#')
    end

    it 'ユーザーを削除できること' do
      visit admins_users_path
      expect(page).to have_content 'user@example.com'
      accept_confirm('本当に削除しますか？') do
        click_on '削除'
      end
      expect(page).to have_no_content 'user@example.com'
    end
  end
end
