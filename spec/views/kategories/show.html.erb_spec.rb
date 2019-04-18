require 'rails_helper'

RSpec.describe "kategories/show", type: :view do
  before(:each) do
    @kategory = assign(:kategory, Kategory.create!(
      :name => "Name",
      :description => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
  end
end
