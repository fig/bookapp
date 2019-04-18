require 'rails_helper'

RSpec.describe "kategories/new", type: :view do
  before(:each) do
    assign(:kategory, Kategory.new(
      :name => "MyString",
      :description => "MyText"
    ))
  end

  it "renders new kategory form" do
    render

    assert_select "form[action=?][method=?]", kategories_path, "post" do

      assert_select "input[name=?]", "kategory[name]"

      assert_select "textarea[name=?]", "kategory[description]"
    end
  end
end
