require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the SessionsHelper. For example:
#
# describe SessionsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe SessionsHelper, type: :helper do
  let!(:user1) { FactoryBot.create(:user1) }

  before do
    remember(user1)
  end

  it "sessionがnilの場合のcurrent_user" do
    expect(user1).to eq current_user
    expect(logged_in?).to eq true
  end

  it "remember_digestが不正な場合current_userはnilになるか" do
    user1.update_attribute(:remember_digest, User.digest(User.new_token))
    expect(current_user).to eq nil
  end

end
