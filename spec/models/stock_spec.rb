require 'rails_helper'

RSpec.describe Stock, type: :model do
  let!(:sample1)  { FactoryBot.create(:sample1) }
  before do 
    @stock = FactoryBot.build(:stock1, item: sample1)
  end
  context 'バリデーション' do
    it 'stockが有効になる' do
      expect(@stock).to be_valid
    end
  end
end
