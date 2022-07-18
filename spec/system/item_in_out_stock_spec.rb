require 'rails_helper'

RSpec.describe "InOutStockItems", type: :system do
    let!(:user1)  { FactoryBot.create(:user1) }
    let!(:item1)  { FactoryBot.create(:item1) }
    let!(:stock1)   { FactoryBot.create(:stock1, item: item1)}

    # it "日ログイン状態でログイン画面に戻される、ログインすると、在庫管理画面に戻る" do
    #     visit edit_stock_path(stock1)
    #     expect(current_path).to eq login_path
    #     log_in_system(user1)
    #     visit current_path #ページをリロード
    #     expect(current_path).to eq edit_stock_path(stock1)
    # end 不安定なため削除　request specへ移行
    
    describe '出庫' do
        before do
            visit login_path
            fill_in 'session[number]', with: 1000
            fill_in 'session[password]', with: "password"
            click_button 'ログイン'
            # log_in_system(user1) requireに依存すると不安定になるため削除
            visit current_path
            visit items_path
            # 出庫へのリンクをクリック
            click_link '出庫'
        end

        it "出庫ページに遷移しているか" do
            expect(current_path).to eq edit_stock_path(stock1)
            expect(page).to have_content "出庫"
        end

        it "formの入力値が正常な場合、出庫が成功するか" do
            # formに出庫数を入力
            fill_in 'stock_form[process_number]', with: 3
            fill_in 'stock_form[day]', with: Date.today
            fill_in 'stock_form[purpose]', with: "sample"
            # 出庫ボタンをクリック
            click_button'出庫'
            # 正しいフラッシュメッセージが表示されているかチェック
            expect(page).to have_content '出庫しました'
            # 出庫処理で在庫数が変化したかテスト
            visit items_path
            expect(page).to have_content stock1.number-3
        end

        it "formの入力値が正常な場合、履歴が正しく作られるか" do
            # formに出庫数を入力
            fill_in 'stock_form[process_number]', with: 3
            fill_in 'stock_form[day]', with: Date.today
            fill_in 'stock_form[purpose]', with: "sample"
            # 出庫ボタンをクリック
            click_button'出庫'
            visit reports_path
            expect(page).to have_content item1.name
        end


        it "formの出庫数が空の場合, 出庫が失敗するか、正しくrenderされるか" do
            # formにnilを入力
            fill_in 'stock_form[process_number]', with: "  "
            fill_in 'stock_form[purpose]', with: "sample"
            # 出庫ボタンをクリック
            click_button'出庫'
            # エラーメッセージが表示されているかチェック
            expect(page).to have_selector "#error_explanation"
            #render先の表示は正しいか
            expect(page).to have_content "出庫"
            #出庫数が変化していないか
            visit items_path
            expect(page).to have_content stock1.number
            visit reports_path
            expect(page).not_to have_selector "td", text:item1.name
        end

        it "formの使用目的が空の場合, 出庫が失敗するか、正しくrenderされるか" do
            expect do
                # formにnilを入力
                fill_in 'stock_form[process_number]', with: 3
                fill_in 'stock_form[purpose]', with: "    "
                # 出庫ボタンをクリック
                click_button'出庫'
                # エラーメッセージが表示されているかチェック
                expect(page).to have_selector "#error_explanation"
                #render先の表示は正しいか
                expect(page).to have_content "出庫"
                #出庫数が変化していないか
            end.to_not change { Stock.find(stock1.id).number }
        end

        # it "formの出庫数が0の場合, 出庫が失敗するか、正しくrenderされるか" do
        #     expect do
        #         # formにnilを入力
        #         fill_in 'stock_form[process_number]', with: 0
        #         fill_in 'stock_form[purpose]', with: "sample"
        #         # 出庫ボタンをクリック
        #         click_button'出庫'
        #         # エラーメッセージが表示されているかチェック
        #         expect(page).to have_selector "#error_explanation"
        #         #render先の表示は正しいか
        #         expect(page).to have_content "出庫"
        #         #出庫数が変化していないか
        #     end.to_not change { Stock.find(stock1.id).number }
        # end

        it "formの入力値が不正な場合、履歴は作られないか" do
            expect do
                # formにnilを入力
                fill_in 'stock_form[process_number]', with: "  "
                # 出庫ボタンをクリック
                click_button'出庫'
            end.to_not change { Report.all.count }
        end
    end

    describe '入庫' do
        before do
            visit login_path
            fill_in 'session[number]', with: 1000
            fill_in 'session[password]', with: "password"
            click_button 'ログイン'
            visit current_path
            # log_in_system(user1) requireに依存すると不安定になるため削除
            visit items_path
            # 出庫へのリンクをクリック
            click_link '入庫'
        end

        it "入庫ページに遷移しているか" do
            expect(current_path).to eq edit_stock_path(stock1)
            expect(page).to have_content "入庫"
        end

        it "formの入力値が正常な場合、入庫が成功するか" do
            expect do
                # formに入力
                fill_in 'stock_form[process_number]', with: 3
                fill_in 'stock_form[day]', with: Date.today
                # 出庫ボタンをクリック
                click_button '入庫'
                # 正しいフラッシュメッセージが表示されているかチェック
                expect(page).to have_content '入庫しました'
            # 出庫処理で在庫数が変化したかテスト
            end.to change { Stock.find(stock1.id).number }.from(30).to(33)
        end

        it "formの入力値が正常な場合、履歴が正しく作られるか" do
            # formに出庫数を入力
            fill_in 'stock_form[process_number]', with: 3
            # 出庫ボタンをクリック
            click_button'入庫'
            visit reports_path
            expect(page).to have_content item1.name
        end

        it "formの入庫数が未入力の場合, 出庫が失敗するか、正しくrenderされるか" do
            expect do
                # formにnilを入力
                fill_in 'stock_form[process_number]', with: "  "
                fill_in 'stock_form[day]', with: Date.today
                # 出庫ボタンをクリック
                click_button'入庫'
                # エラーメッセージが表示されているかチェック
                expect(page).to have_selector "#error_explanation"
                #render先の表示は正しいか
                expect(page).to have_content "入庫"
                # エラーメッセージが表示されているか
                expect(page).to have_selector "#error_explanation"
                #出庫数が変化していないか
            end.to_not change { Stock.find(stock1.id).number }
        end

        it "formの入力値が不正な場合、履歴は作られないか" do
            expect do
                # formにnilを入力
                fill_in 'stock_form[process_number]', with: "  "
                fill_in 'stock_form[day]', with: Date.today
                # 出庫ボタンをクリック
                click_button'入庫'
            end.to_not change { Report.all.count }
        end
    end

end


