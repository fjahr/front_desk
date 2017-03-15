require "rails_helper"

RSpec.feature "View Dashboard", type: :feature do
  before :each do
    user = FactoryGirl.create(:user)
    FactoryGirl.create(:account, :subscribed, user: user)
    login_as(user, :scope => :user)
  end

  scenario "User visits the dashboard" do
    visit "/dashboard"

    expect(page).to have_content('Dashboard')
  end
end
