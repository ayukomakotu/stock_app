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

        it "nameの一意性は担保されているか" do
            @user.save
            dup_user = @user.dup
            expect(dup_user).to be_invalid
        end

        it "passwordが空で無効になる" do
            @user.password = "  "
            expect(@user).to be_invalid
        end

        it "password_confirmationが空で無効になる" do
            @user.password_confirmation = "  "
            expect(@user).to be_invalid
        end

        it "passwordが6文字未満で無効になる" do
            @user.password = "a" * 5
            expect(@user).to be_invalid
        end
    end
end