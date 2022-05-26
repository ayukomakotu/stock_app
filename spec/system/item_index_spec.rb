require 'rails_helper'

RSpec.describe "IndexItems", type: :system do
    let!(:user1)  { FactoryBot.create(:user1) }
    let!(:item1)  { FactoryBot.create(:item1) }
    let!(:stock1)   { FactoryBot.create(:stock1, item: item1)}
    
    it "在庫表の表示のテスト" do
        visit items_path
        # 日ログイン状態でログイン画面に戻される
        expect(current_path).to eq login_path
        log_in_system(user1)
        visit items_path
        # ページ上に特定の文字列が表示されているか
        expect(page).to have_content item1.name
        expect(page).to have_content item1.unit
        expect(page).to have_content item1.stock.number
    end
end


