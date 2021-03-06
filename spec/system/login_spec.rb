require 'rails_helper'

RSpec.describe "Login", type: :system do
    let!(:user1) { FactoryBot.create(:user1) }

    context "有効な値の場合" do

        it "ログインが成功する" do
            visit login_path 
            fill_in 'session[number]', with: 1000
            fill_in 'session[password]', with: "password"
            click_button 'ログイン'
            expect(page).to have_content 'ログインに成功しました'
            visit current_path
            expect(current_path).to eq items_path
        end
    end

    context "無効な値の場合" do
        it "ログインが成功しない" do
            visit login_path
            fill_in 'session[number]', with: 100
            fill_in 'session[password]', with: "invalid"
            click_button 'ログイン'
            expect(current_path).to eq login_path
            expect(page).to have_content '番号またはパスワードが間違っています'
        end
    end
end