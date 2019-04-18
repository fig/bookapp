require 'rails_helper'

RSpec.describe "kategories/edit", type: :view do
  before(:each) do
    @kategory = assign(:kategory, Kategory.create!(
      :name => "MyString",
      :description => "MyText"
    ))
  end

  it "renders the edit kategory form" do
    render

    assert_select "form[action=?][method=?]", kategory_path(@kategory), "post" do

      assert_select "input[name=?]", "kategory[name]"

      assert_select "textarea[name=?]", "kategory[description]"
    end
  end
end
