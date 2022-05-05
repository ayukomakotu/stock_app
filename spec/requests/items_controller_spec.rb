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
end
