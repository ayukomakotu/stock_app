require 'rails_helper'

RSpec.describe "ItemNew", type: :system do
    let!(:user1)  { FactoryBot.create(:user1) }

    it "正しい値を入力すると登録できるか" do
        # log_in_system(user1) requireに依存すると不安定なため削除
        visit login_path 
        fill_in 'session[number]', with: 1000
        fill_in 'session[password]', with: "password"
        click_button 'ログイン'
        visit current_path
        visit new_item_path
        fill_in "item_form[name]", with: "sample"
        fill_in "item_form[number]", with: 30
        fill_in "item_form[unit]", with: "個"
        click_on "登録"
        expect(page).to have_content "sample"
        expect(page).to have_content 30
        expect(page).to have_content "個" 
    end

    it "不正な値を入力すると、失敗するか" do
        # log_in_system(user1) requireに依存すると不安定なため削除
        visit login_path 
        fill_in 'session[number]', with: 1000
        fill_in 'session[password]', with: "password"
        click_button 'ログイン'
        visit current_path
        visit new_item_path
        fill_in "item_form[name]", with: "    "
        fill_in "item_form[number]", with: 30
        fill_in "item_form[unit]", with: "個"
        click_on "登録"
        expect(page).to have_selector "#error_explanation"

        fill_in "item_form[name]", with: "sample"
        fill_in "item_form[number]", with: nil
        fill_in "item_form[unit]", with: "個"
        click_on "登録"
        expect(page).to have_selector "#error_explanation"

        fill_in "item_form[name]", with: "sample"
        fill_in "item_form[number]", with: nil
        fill_in "item_form[unit]", with: "  "
        click_on "登録"
        expect(page).to have_selector "#error_explanation"
    end
end