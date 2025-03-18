RSpec.describe 'Admins::Sessions', type: :system do
  let!(:admin) { create(:admin, email: 'admin@example.com', password: 'password123#') }

  context 'ログインしているとき' do
    before do
      sign_in(admin, scope: :admin)
    end

    it 'ログアウトの確認' do
      visit admins_root_path
      accept_confirm('本当にログアウトしますか?') do
        click_on 'ログアウト'
      end
      expect(page).to have_content 'ログアウトしました。'
    end
  end

  context 'ログアウトしているとき' do
    it 'ログインの確認' do
      visit new_admin_session_path
      fill_in 'Eメール', with: 'admin@example.com'
      fill_in 'パスワード', with: 'password123#'
      click_button 'ログイン'
      expect(page).to have_content 'ログインしました。'
      expect(page).to have_current_path admins_root_path
    end

    it '管理者ページにアクセス不可' do
      visit admins_root_path
      expect(page).to have_current_path new_admin_session_path
    end
  end
end
