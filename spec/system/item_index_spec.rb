require 'rails_helper'

RSpec.describe "IndexItems", type: :system do
    let!(:sample1)  { FactoryBot.create(:sample1) }
    
    it "在庫表の表示のテスト" do
        visit items_path
        # ページ上に特定の文字列が表示されているか
        expect(page).to have_content sample1.name
        expect(page).to have_content sample1.unit
    end
end


