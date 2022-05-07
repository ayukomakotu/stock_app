require 'rails_helper'

RSpec.describe "ItemsControllers", type: :request do
  
  let!(:sample1)  { FactoryBot.create(:sample1) }
  let!(:sample2)  { FactoryBot.create(:sample2) }

  describe "GET /index" do
    it "リクエストが成功するか" do
      get items_path
      expect(response.status).to eq 200
    end
  end

  describe "GET :id/out_stock" do
    it "リクエストが成功するか" do
      get out_stock_item_path(sample1)
      expect(response.status).to eq 200
    end
  end

  describe "PUT #update" do
    context '更新' do
      context 'パラメータが妥当な場合' do
        it "更新用リクエストが成功するか" do
          patch item_path(sample1), params: { item: {id: sample1.id, name: sample1.name, 
                          stock: sample1.stock, unit: sample1.unit }}
          expect(response.status).to eq 302
        end

        it "更新でitem名が更新されるか" do
          expect do
            patch item_path(sample1), params: { item: {id: sample1.id, name: "sample3", 
                          stock: sample1.stock, unit: sample1.unit }}
          end.to change { Item.find(sample1.id).name }.from('sample1').to('sample3')
        end
      end

      context 'パラメータが不正な場合' do

        it 'リクエストが成功するか' do
          patch item_path(sample1), params: { item: {id: sample1.id, name: nil, 
                          stock: sample1.stock, unit: sample1.unit }}
          expect(response.status).to eq 200
        end

        it "nameが変更されないか" do
          expect do
            patch item_path(sample1), params: { item: {id: sample1.id, name: nil, 
                          stock: sample1.stock, unit: sample1.unit }}
          end.to_not change(Item.find(sample1.id), :name)
        end

        pending "エラーが表示されるか" do
          patch item_path(sample1), params: { item: {id: sample1.id, name: nil, 
                          stock: sample1.stock, unit: sample1.unit }}
          expect(response.body).to include 'prohibited this user from being saved'
        end   
      end
    end

    context '入出庫' do
      context 'パラメータが有効な場合' do
        it "リクエストが成功するか" do
          patch item_path(sample1), params: { item: {id: sample1.id, name: sample1.name, 
                          stock: sample1.stock, unit: sample1.unit, process_number: 3 }}
          expect(response.status).to eq 302
        end

        it "出庫処理が正しく行われたか" do
          expect do
            patch item_path(sample1), params: { item: {id: sample1.id, name: sample1.name, 
                    stock: sample1.stock, unit: sample1.unit, process_number: 3 }, commit: "出庫" }
          end.to change { Item.find(sample1.id).stock }.from(10).to(7)
        end

        it "入庫処理が正しく行われたか" do
          expect do
            patch item_path(sample1), params: { item: {id: sample1.id, name: sample1.name, 
                    stock: sample1.stock, unit: sample1.unit, process_number: 3 }, commit: "入庫" }
          end.to change { Item.find(sample1.id).stock }.from(10).to(13)
        end
      end

      context 'パラメータが無効な場合' do

        pending 'リクエストが成功すること' do
          patch patch item_path(sample1), params: { item: {id: sample1.id, name: sample1.name, 
                  stock: sample1.stock, unit: sample1.unit, process_number: nil }}
          expect(response.status).to eq 200
        end

        # pending 'stockが変更されないか（入出庫）' do
        # end
      end
    end
  end              
end
