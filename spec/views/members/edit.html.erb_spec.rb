require 'rails_helper'

RSpec.describe "members/edit", type: :view do
  before(:each) do
    @member = assign(:member, Member.create!(
      :account => nil,
      :name => "MyString",
      :email => "MyString",
      :phone => "MyString",
      :slack_id => "MyString",
      :hipchat_id => "MyString"
    ))
  end

  it "renders the edit member form" do
    render

    assert_select "form[action=?][method=?]", member_path(@member), "post" do

      assert_select "input#member_name[name=?]", "member[name]"

      assert_select "input#member_email[name=?]", "member[email]"

      assert_select "input#member_slack_id[name=?]", "member[slack_id]"
    end
  end
end
