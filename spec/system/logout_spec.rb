require 'rails_helper'

RSpec.describe "Logout", type: :system do

    let!(:user1) { FactoryBot.create(:user1) }

    it "ログアウトに成功する" do
        log_in_system(user1)
        click_on 'ログアウト'
        visit current_path
        expect(current_path).to eq login_path
        expect(user1.authenticated?('')).to eq false
    end
end