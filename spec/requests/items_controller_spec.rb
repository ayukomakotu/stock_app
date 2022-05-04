require 'rails_helper'

RSpec.describe "ItemsControllers", type: :request do
  let!(:sample1)  { FactoryBot.create(:sample1) }
  let!(:sample2)  { FactoryBot.create(:sample2) }

  describe "GET /index" do
    it "リクエストが成功するか" do
      get items_path
      expect(response.status).to eq 200
    end

    it '在庫表が表示されているか' do
      get items_path 
      expect(response.body).to include sample1.name
      expect(response.body).to include sample2.name
    end
  end
end
