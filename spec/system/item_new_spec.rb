require 'rails_helper'

RSpec.describe "ItemNew", type: :system do
    let!(:user1)  { FactoryBot.create(:user1) }

    it "正しい値を入力すると登録できるか" do
        log_in_system(user1)
        visit new_item_path
        fill_in "item[name]", with: "sample"
        fill_in "item[stock]", with: 30
        fill_in "item[unit", with: "個"
        click_on "登録"
        expect(page).to have_content "sample"
        expect(page).to have_content 30
        expect(page).to have_content "個" 
    end

    it "不正な値を入力すると、失敗するか" do
        log_in_system(user1)
        visit new_item_path
        fill_in "item[name]", with: "    "
        fill_in "item[stock]", with: 30
        fill_in "item[unit", with: "個"
        expect(page).to have_selector "#error_explanation"

        fill_in "item[name]", with: "sample"
        fill_in "item[stock]", with: nil
        fill_in "item[unit", with: "個"
        expect(page).to have_selector "#error_explanation"

        fill_in "item[name]", with: "sample"
        fill_in "item[stock]", with: nil
        fill_in "item[unit", with: "  "
        expect(page).to have_selector "#error_explanation"
    end
end