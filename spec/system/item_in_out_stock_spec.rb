require 'rails_helper'

RSpec.describe "InOutStockItems", type: :system do
    let!(:sample1)  { FactoryBot.create(:sample1) }
    
    describe '出庫' do
        before do
            visit items_path
            # 出庫へのリンクをクリック
            click_link '出庫'
            # item/:id/out_stockに遷移したかテスト
            expect(current_path).to eq out_stock_item_path(sample1)
        end

        it "formの入力値が正常な場合、出庫が成功するか" do
            expect do
                # formに出庫数を入力
                fill_in 'item[process_number]', with: 3
                # 出庫ボタンをクリック
                click_button'出庫'
                # 正しいフラッシュメッセージが表示されているかチェック
                expect(page).to have_content '出庫しました'
            # 出庫処理で在庫数が変化したかテスト
            end.to change { Item.find(sample1.id).stock }.from(10).to(7)
        end

        pending "formの出庫数が未入力の場合, 出庫が失敗するか" do
            # formにnilを入力
            fill_in 'item[process_number]', with: nil
            # 出庫ボタンをクリック
            click_button'出庫'
            # エラーメッセージが表示されているかチェック
            expect(page).to have_content '出庫数を入力してください'
        end
    end
end


