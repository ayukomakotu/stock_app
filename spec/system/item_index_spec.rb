require 'rails_helper'

RSpec.describe "IndexItems", type: :system do
    let!(:item1)  { FactoryBot.create(:item1) }
    let!(:stock1)   { FactoryBot.create(:stock1, item: item1)}
    
    it "在庫表の表示のテスト" do
        visit items_path
        # ページ上に特定の文字列が表示されているか
        expect(page).to have_content item1.name
        expect(page).to have_content item1.unit
    end
end


