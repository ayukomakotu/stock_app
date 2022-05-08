require 'rails_helper'

RSpec.describe Item, type: :model do
    before do 
        @item = FactoryBot.build(:sample1)
    end

    context 'バリデーション' do
        it 'itemが有効になるか' do
            expect(@item).to be_valid
        end

        it 'nameが空で無効になるか' do
            @item.name = "    "
            expect(@item).to be_invalid
        end

        it "nameの一意性は担保されているか" do
            @item.save
            dup_item = @item.dup
            expect(dup_item).to be_invalid
        end

        it "unitが空で無効になるか" do
            @item.unit = nil
            expect(@item).to be_invalid
        end
    end
end