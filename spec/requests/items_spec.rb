require 'rails_helper'

RSpec.describe "ItemsControllers", type: :request do

  let!(:user1)  { FactoryBot.create(:user1)}
  
  let!(:item1)  { FactoryBot.create(:item1) }
  let!(:item2)  { FactoryBot.create(:item2) }
  # itemに関連づけたstockをFactoryBotで作成
  let!(:stock1)   { FactoryBot.create(:stock1, item: item1) }
  let!(:stock2)   { FactoryBot.create(:stock2, item: item2) }

  describe "GET /index" do
    it "リクエストが成功するか" do
      log_in_as(user1)
      get items_path
      expect(response.status).to eq 200
    end
  end
end

  

    # context '入出庫' do
    #   context 'パラメータが有効な場合' do
    #     it "リクエストが成功するか" do
    #       patch item_path(sample1), params: { item: {id: sample1.id, name: sample1.name, 
    #                       stock: sample1.stock, unit: sample1.unit, process_number: 3 }}
    #       expect(response.status).to eq 302
    #     end

    #     it "出庫処理が正しく行われ在庫数が減っているか、リダイレクトするか" do
    #       expect do
    #         patch item_path(sample1), params: { item: {id: sample1.id, name: sample1.name, 
    #                 stock: sample1.stock, unit: sample1.unit, process_number: 3 }, commit: "出庫" }
    #       end.to change { Item.find(sample1.id).stock }.from(10).to(7)
    #       expect(response).to redirect_to items_path
    #     end

    #     it "入庫処理が正しく行われ在庫数が増えているか、リダイレクトするか" do
    #       expect do
    #         patch item_path(sample1), params: { item: {id: sample1.id, name: sample1.name, 
    #                 stock: sample1.stock, unit: sample1.unit, process_number: 3 }, commit: "入庫" }
    #       end.to change { Item.find(sample1.id).stock }.from(10).to(13)
    #       expect(response).to redirect_to items_path
    #     end