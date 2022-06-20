require 'rails_helper'

RSpec.describe "Sessions", type: :request do

  let!(:user1) { FactoryBot.create(:user1) }

  describe "GET /login" do
    it "リクエストが成功するか" do
      get login_path
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /login" do
    it "リクエストが成功するか" do
      post login_path, params: { session: { number: user1.number, password: user1.password }}
      expect(response).to have_http_status(302)
    end
  end

  describe "DELETE /loguot" do
    it "リクエストが成功するか" do
      post login_path, params: { session: { number: user1.number, password: user1.password }}
      delete logout_path
      expect(response).to have_http_status(302)
    end

    it "二番目のウインドウでのログアウト" do
      post login_path, params: { session: { number: user1.number, password: user1.password }}
      delete logout_path
      expect(response).to have_http_status(302)
      delete logout_path
      expect(response).to have_http_status(302)
    end
  end

end
