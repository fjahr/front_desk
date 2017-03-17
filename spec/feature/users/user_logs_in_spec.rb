require "rails_helper"

RSpec.feature "User logs in", type: :feature do
  before :each do
    user = FactoryGirl.create(:user)
    FactoryGirl.create(:account, :subscribed, user: user)
  end

  scenario "and is redirected to dashboard" do
    visit "/"

    within(:css, "ul.navbar-nav") do
      click_on "Login"
    end

    fill_in('inputEmail', with: 'test@example.com')
    fill_in('inputPassword', with: 'f4k3p455w0rd')

    click_on "Log in"

    expect(page).to have_content('Dashboard')
    expect(page).to have_content('Logout')
  end
end
