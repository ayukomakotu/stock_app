require 'rails_helper'

RSpec.describe "Header", type: :system do
    let!(:user1)  { FactoryBot.create(:user1) }

    context 'ログイン状態' do
        it "リンクが正しいか" do
            log_in_system(user1)
            find(".navbar-brand").click
            expect(current_path).to eq root_path
            click_on "在庫表"
            expect(current_path).to eq items_path
            click_on "処理履歴"
            expect(current_path).to eq reports_path
            click_on "ログアウト"
            visit current_path
            expect(current_path).to eq login_path
        end
    end

    context '非ログイン状態' do
        it "リンクが正しいか" do
            visit reports_path
            expect(current_path).to eq login_path
            expect(page).not_to have_link '在庫表', href: items_path
            expect(page).not_to have_link '処理履歴', href: reports_path
            expect(page).not_to have_link 'ログアウト', href: logout_path
            click_on "ログイン"
            visit current_path
            expect(current_path).to eq login_path
        end
    end
end

