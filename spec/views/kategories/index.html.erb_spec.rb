require 'rails_helper'

RSpec.describe "kategories/index", type: :view do
  before(:each) do
    assign(:kategories, [
      Kategory.create!(
        :name => "Name",
        :description => "MyText"
      ),
      Kategory.create!(
        :name => "Name",
        :description => "MyText"
      )
    ])
  end

  it "renders a list of kategories" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
