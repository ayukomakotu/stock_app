require 'rails_helper'

RSpec.describe "Reports", type: :request do
  describe "GET /index" do
    it "リクエストが成功するか" do
      get reports_path
      expect(response).to have_http_status(:success)
    end
  end

end
