RSpec.describe 'ユーザーのログイン機能', type: :system do
  let!(:user) { create(:user, email: 'user@example.com', password: 'password123#') }

  context 'ログインしているとき' do
    before do
      sign_in(user, scope: :user)
    end

    it 'ログアウトの確認' do
      visit root_path
      accept_confirm('本当にログアウトしますか?') do
        click_on 'ログアウト'
      end
      expect(page).to have_content 'ログアウトしました。'
    end
  end

  context 'ログアウトしているとき' do
    it 'ログインの確認' do
      visit new_user_session_path
      fill_in 'メールアドレス', with: 'user@example.com'
      fill_in 'パスワード', with: 'password123#'
      click_button 'ログイン'
      expect(page).to have_content 'ログインしました。'
      expect(page).to have_content 'user@example.com'
    end
  end
end
