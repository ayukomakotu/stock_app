require 'rails_helper'

RSpec.describe "Reports", type: :request do

  let!(:user1)    { FactoryBot.create(:user1)}
  let!(:item1)    { FactoryBot.create(:item1)}
  let!(:report1)  { FactoryBot.create(:report1, user: user1, item: item1)}
  describe "GET /index" do
    it "リクエストが成功するか" do
      log_in_as(user1)
      get reports_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH /update" do
    it "リクエストが成功するか" do
      log_in_as(user1)
      patch report_path(report1), params: { report: { confirmer_id: user1.id, comnfirmation: true}}
      expect(response).to have_http_status(302)
      expect(report1.reload.confirmer_id).to eq user1.id
    end
  end

end
