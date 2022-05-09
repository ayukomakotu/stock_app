require 'rails_helper'

RSpec.describe "ItemsControllers", type: :request do
  
  let!(:sample1)  { FactoryBot.create(:sample1) }
  let!(:sample2)  { FactoryBot.create(:sample2) }
  # itemに関連づけたstockをFactoryBotで作成
  let!(:stock1)   { FactoryBot.create(:stock1, item: sample1) }
  let!(:stock2)   { FactoryBot.create(:stock2, item: sample2) }

  describe "GET /index" do
    it "リクエストが成功するか" do
      get items_path
      expect(response.status).to eq 200
    end
  end

  describe "PATCH #update" do
    context 'パラメータが妥当な場合' do
      pending "リクエストが成功するか" do
        patch item_path(sample1), params: { item: FactoryBot.attributes_for(:sample2) }
        expect(response.status).to eq 302
      end

      pending "更新でitem名が更新されるか" do
        expect do
          patch item_path(sample1), params: { item: FactoryBot.attributes_for(:sample2) }
        end.to change { Item.find(sample1.id).name }.from('sample1').to('sample2')
      end
    end

    context 'パラメータが不正な場合' do

      it 'リクエストが成功するか' do
        patch item_path(sample1), params: { item: { name: "   ", unit: "個"}}
        expect(response.status).to eq 200
      end

      it "nameが変更されないか" do
        expect do
          patch item_path(sample1), params: { item: { name: "   ", unit: "個"}}
        end.to_not change(Item.find(sample1.id), :name)
      end

      pending "エラーが表示されるか" do
        patch item_path(sample1), params: { item: {id: sample1.id, name: nil, 
                        stock: sample1.stock, unit: sample1.unit }}
        expect(response.body).to include 'prohibited this user from being saved'
      end   
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