require 'rails_helper'

RSpec.describe "Reports", type: :request do
  let!(:user1)  { FactoryBot.create(:user1)}
  describe "GET /index" do
    it "リクエストが成功するか" do
      log_in_as(user1)
      get reports_path
      expect(response).to have_http_status(:success)
    end
  end

end
