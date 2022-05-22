require 'rails_helper'

RSpec.describe "Login", type: :system do
    let!(:user1) { FactoryBot.create(:user1) }

    context "有効な値の場合" do

        it "ログインが成功する" do
            visit login_path 
            fill_in 'session[number]', with: user1.number
            fill_in 'session[password]', with: user1.password
            
            click_button 'ログイン'
            expect(current_path).to eq items_path
        end
    end
end