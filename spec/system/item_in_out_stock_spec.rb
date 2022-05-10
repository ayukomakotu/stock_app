require 'rails_helper'

RSpec.describe "InOutStockItems", type: :system do
    let!(:item1)  { FactoryBot.create(:item1) }
    let!(:stock1)   { FactoryBot.create(:stock1, item: item1)}
    
    describe '出庫' do
        before do
            visit items_path
            # 出庫へのリンクをクリック
            click_link '出庫'
            # item/:id/out_stockに遷移したかテスト
            expect(current_path).to eq edit_stock_path(stock1)
        end

        it "formの入力値が正常な場合、出庫が成功するか" do
            expect do
                # formに出庫数を入力
                fill_in 'stock[process_number]', with: 3
                # 出庫ボタンをクリック
                click_button'出庫'
                # 正しいフラッシュメッセージが表示されているかチェック
                expect(page).to have_content '出庫しました'
            # 出庫処理で在庫数が変化したかテスト
            end.to change { Stock.find(stock1.id).number }.from(30).to(27)
        end

        it "formの出庫数が未入力の場合, 出庫が失敗するか、正しくrenderされるか" do
            expect do
                # formにnilを入力
                fill_in 'stock[process_number]', with: "  "
                # 出庫ボタンをクリック
                click_button'出庫'
                # エラーメッセージが表示されているかチェック
                expect(page).to have_content "正しい数値を入力してください"
                #render先の表示は正しいか
                expect(page).to have_content "出庫"
                #出庫数が変化していないか
            end.to_not change { Stock.find(stock1.id).number }
        end
    end

    describe '入庫' do
        before do
            visit items_path
            # 出庫へのリンクをクリック
            click_link '入庫'
            # item/:id/out_stockに遷移したかテスト
            expect(current_path).to eq edit_stock_path(stock1)
        end

        it "formの入力値が正常な場合、入庫が成功するか" do
            expect do
                # formに出庫数を入力
                fill_in 'stock[process_number]', with: 3
                # 出庫ボタンをクリック
                click_button '入庫'
                # 正しいフラッシュメッセージが表示されているかチェック
                expect(page).to have_content '入庫しました'
            # 出庫処理で在庫数が変化したかテスト
            end.to change { Stock.find(stock1.id).number }.from(30).to(33)
        end

        it "formの入庫数が未入力の場合, 出庫が失敗するか、正しくrenderされるか" do
            expect do
                # formにnilを入力
                fill_in 'stock[process_number]', with: "  "
                # 出庫ボタンをクリック
                click_button'入庫'
                # エラーメッセージが表示されているかチェック
                expect(page).to have_content "正しい数値を入力してください"
                #render先の表示は正しいか
                expect(page).to have_content "入庫"
                #出庫数が変化していないか
            end.to_not change { Stock.find(stock1.id).number }
        end
    end

end


