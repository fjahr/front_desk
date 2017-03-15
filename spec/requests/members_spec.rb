require 'rails_helper'

RSpec.describe "Members", type: :request do
    before :each do
    user = FactoryGirl.create(:user)
    FactoryGirl.create(:account, :subscribed, user: user)
    login_as(user, :scope => :user)
  end

  describe "GET /members" do
    it "works! (now write some real specs)" do
      get members_path
      expect(response).to have_http_status(200)
    end
  end
end
