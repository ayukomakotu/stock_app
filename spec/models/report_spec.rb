require 'rails_helper'

RSpec.describe Report, type: :model do
  
  let!(:user1) { FactoryBot.create(:user1) }
  let!(:item1) { FactoryBot.create(:item1) }

  before do
    @report = FactoryBot.build(:report1, user: user1, item: item1)
  end

  describe 'バリデーション' do
    it "reportが有効になるか" do
      expect(@report).to be_valid
    end

    it "processが空で無効になるか" do
      @report.process = "  "
      expect(@report).to be_invalid
    end

    it "process_numberが空で無効になるか" do
      @report.process_number = nil
      expect(@report).to be_invalid
    end

    it "dayが空で無効なるか" do
      @report.day = nil
      expect(@report).to be_invalid
    end

  end
end
