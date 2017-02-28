require 'rails_helper'

RSpec.describe "members/show", type: :view do
  before(:each) do
    @member = assign(:member, Member.create!(
      :account => nil,
      :name => "Name",
      :email => "Email",
      :phone => "Phone",
      :slack_id => "Slack",
      :hipchat_id => "Hipchat"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Phone/)
    expect(rendered).to match(/Slack/)
    expect(rendered).to match(/Hipchat/)
  end
end
