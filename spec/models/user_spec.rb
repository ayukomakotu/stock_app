require 'rails_helper'

RSpec.describe User, type: :model do
    before do
        @user = FactoryBot.build(:user1)
    end

    context 'バリデーション' do
        it "userが有効になる" do
            expect(@user).to be_valid
        end
    
        it "nameが空で無効になる" do
            @user.name = "    "
            expect(@user).to be_invalid
        end

        it "numberが空で無効になる" do
            @user.name = nil
            expect(@user).to be_invalid
        end
    end
end