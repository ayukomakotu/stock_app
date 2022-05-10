require 'rails_helper'

RSpec.describe Stock, type: :model do
  let!(:item1)  { FactoryBot.create(:item1) }
  before do 
    @stock = FactoryBot.build(:stock1, item: item1)
  end
  context 'バリデーション' do
    it 'stockが有効になる' do
      expect(@stock).to be_valid
    end
  end
end
