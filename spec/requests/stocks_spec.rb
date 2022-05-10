require 'rails_helper'

RSpec.describe "Stocks", type: :request do

  let!(:item1)  { FactoryBot.create(:item1) }
  let!(:item2)  { FactoryBot.create(:item2) }
  # itemに関連づけたstockをFactoryBotで作成
  let!(:stock1)   { FactoryBot.create(:stock1, item: item1) }
  let!(:stock2)   { FactoryBot.create(:stock2, item: item2) }

  describe "GET /edit" do
    it "リクエストが成功するか" do
      get edit_stock_path(stock1)
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH /update" do
    it "リクエストが成功するか" do
      patch stock_path(stock1), params: { stock: { process_number: 5 }} 
      expect(response.status).to eq 302
    end
  end

end
