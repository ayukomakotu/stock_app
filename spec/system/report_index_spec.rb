require 'rails_helper'

RSpec.describe "ReportItems", type: :system do
    let!(:user1)  { FactoryBot.create(:user1) }
    let!(:item1)  { FactoryBot.create(:item1) }
    let!(:item2)  { FactoryBot.create(:item2) }
    let!(:stock1)   { FactoryBot.create(:stock1, item: item1)}
    let!(:stock2)   { FactoryBot.create(:stock2, item: item2)}
    let!(:report1)   { FactoryBot.create(:report1, user: user1, item: item1)}
    let!(:report2)   { FactoryBot.create(:report2, user: user1, item: item2)}

    
    it "処理履歴一覧の表示は正しいか" do
        visit reports_path
        # 日ログイン状態でログイン画面に戻される
        expect(current_path).to eq login_path
        log_in_system(user1)
        visit reports_path
        # ページ上に特定の文字列が表示されているか
        expect(page).to have_content "#{report1.day.year}年#{report1.day.month}月#{report1.day.day}日"
        expect(page).to have_content report1.process
        expect(page).to have_content report1.process_number
        expect(page).to have_content report1.item.unit
        expect(page).to have_content report1.purpose
        expect(page).to have_content "顧客管理ソフトへ未入力の処理が残っています"
        expect(page).to have_link "削除する", href: report_path(report1)
    end

    it "入力確認は正しく処理されたか" do
        # 入力確認のテスト
        log_in_system(user1)
        visit reports_path
        click_on "未入力"
        page.driver.browser.switch_to.alert.accept
        expect(page).not_to have_content "顧客管理ソフトへ未入力の処理が残っています"
    end
    
    it "ページネーションが正しく機能しているか, reportが日付順になっているか" do
        # テストデータをまとめて作る
        reports = FactoryBot.create_list(:sample, 30, user: user1, item: item1)
        log_in_system(user1)
        visit reports_path
        click_on "2"
        expect(page).to have_content "sample使用"
    end

    it "正しく絞込みできるか" do
        log_in_system(user1)
        visit reports_path
        fill_in "key[month]", with: "002022-5"
        click_on "絞込み"
        expect(page).not_to have_content "2022年6月"
        expect(page).to have_content "2022年5月"
        fill_in "key_month", with: ""
        select(value = "2", from: "key_item_id")
        click_on "絞込み"
        expect(page).not_to have_selector "td", text: item1.name
        expect(page).to have_selector "td", text: item2.name
    end

    it "削除できるか, 在庫数が戻るか" do
        log_in_system(user1)
        visit reports_path
        expect do
            expect(page).to have_content item1.name
            first(".link-secondary").click
            page.driver.browser.switch_to.alert.accept
            expect(page).not_to have_selector "td", text: item1.name
            stock1.reload
        end.to change { stock1.number }.by(report1.process_number)
        
        
    end

end


