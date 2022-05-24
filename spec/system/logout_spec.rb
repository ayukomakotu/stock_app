RSpec.describe "Login", type: :system do
    let!(:user1) { FactoryBot.create(:user1) }

    it "ログアウトに成功する" do
        log_in_system(user1)
        find(".dropdown-toggle").click
        click_button 'ログアウト'
        expect(current_path).to eq login_path
    end
end