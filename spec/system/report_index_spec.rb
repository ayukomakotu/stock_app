require 'rails_helper'

RSpec.describe "IndexItems", type: :system do
    let!(:user1)  { FactoryBot.create(:user1) }
    let!(:item1)  { FactoryBot.create(:item1) }
    let!(:stock1)   { FactoryBot.create(:stock1, item: item1)}
    let!(:report1)   { FactoryBot.create(:report1, user: user1, item: item1)}

    
    it "処理履歴一覧の表示は正しいか" do
        visit reports_path
        # 日ログイン状態でログイン画面に戻される
        expect(current_path).to eq login_path
        log_in_system(user1)
        visit reports_path
        # ページ上に特定の文字列が表示されているか
        expect(page).to have_content report1.day
        expect(page).to have_content report1.process
        expect(page).to have_content report1.process_number
        expect(page).to have_content report1.item.unit
        expect(page).to have_content report1.purpose
        expect(page).to have_content "顧客管理ソフトへ未入力の処理が残っています"
    end

    it "入力確認は正しく処理されたか" do
        # 入力確認のテスト
        log_in_system(user1)
        visit reports_path
        click_on "未入力"
        page.driver.browser.switch_to.alert.accept
        expect(page).not_to have_content "顧客管理ソフトへ未入力の処理が残っています"
    end
    
    it "ページネーションが正しく機能しているか" do
        # テストデータをまとめて作る
        reports = FactoryBot.create_list(:sample, 30, user: user1, item: item1)
        log_in_system(user1)
        visit reports_path
        click_on "2"
        expect(page).to have_content "sample使用"
    end
end


