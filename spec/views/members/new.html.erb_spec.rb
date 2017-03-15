require 'rails_helper'

RSpec.describe "members/new", type: :view do
  before(:each) do
    assign(:member, Member.new(
      :account => nil,
      :name => "MyString",
      :email => "MyString",
      :phone => "MyString",
      :slack_id => "MyString",
      :hipchat_id => "MyString"
    ))
  end

  it "renders new member form" do
    render

    assert_select "form[action=?][method=?]", members_path, "post" do

      assert_select "input#member_name[name=?]", "member[name]"

      assert_select "input#member_email[name=?]", "member[email]"

      assert_select "input#member_slack_id[name=?]", "member[slack_id]"
    end
  end
end
