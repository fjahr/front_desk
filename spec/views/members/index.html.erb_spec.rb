require 'rails_helper'

RSpec.describe "members/index", type: :view do
  before(:each) do
    assign(:members, [
      Member.create!(
        :account => nil,
        :name => "Name",
        :email => "Email",
        :phone => "Phone",
        :slack_id => "Slack",
        :hipchat_id => "Hipchat"
      ),
      Member.create!(
        :account => nil,
        :name => "Name",
        :email => "Email",
        :phone => "Phone",
        :slack_id => "Slack",
        :hipchat_id => "Hipchat"
      )
    ])
  end

  it "renders a list of members" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Phone".to_s, :count => 2
    assert_select "tr>td", :text => "Slack".to_s, :count => 2
    assert_select "tr>td", :text => "Hipchat".to_s, :count => 2
  end
end
