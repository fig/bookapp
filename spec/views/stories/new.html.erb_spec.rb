require 'rails_helper'

RSpec.describe "stories/new", type: :view do
  before(:each) do
    assign(:story, Story.new(
      :title => "MyString",
      :about => "MyText",
      :copyright => "MyText",
      :characters => "MyText",
      :author => "MyString",
      :user_id => 1,
      :kategory => ""
    ))
  end

  it "renders new story form" do
    render

    assert_select "form[action=?][method=?]", stories_path, "post" do

      assert_select "input[name=?]", "story[title]"

      assert_select "textarea[name=?]", "story[about]"

      assert_select "textarea[name=?]", "story[copyright]"

      assert_select "textarea[name=?]", "story[characters]"

      assert_select "input[name=?]", "story[author]"

      assert_select "input[name=?]", "story[user_id]"

      assert_select "input[name=?]", "story[kategory]"
    end
  end
end
