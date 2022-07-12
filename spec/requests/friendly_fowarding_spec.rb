require 'rails_helper'

RSpec.describe "FriendlyFowarding", type: :request do
  let!(:user1)  { FactoryBot.create(:user1)}

#   let!(:item1)  { FactoryBot.create(:item1) }
#   let!(:item2)  { FactoryBot.create(:item2) }
#   # itemに関連づけたstockをFactoryBotで作成
#   let!(:stock1)   { FactoryBot.create(:stock1, item: item1) }
#   let!(:stock2)   { FactoryBot.create(:stock2, item: item2) }

    it "フレンドリーフォワーディングが機能しているか" do
        get reports_path
        expect(response).to redirect_to login_path
        log_in_as(user1)
        expect(response).to redirect_to reports_path
    end
end