require 'rails_helper'

RSpec.describe "registered_applications/index", type: :view do
  before(:each) do
    assign(:registered_applications, [
      RegisteredApplication.create!(),
      RegisteredApplication.create!()
    ])
  end

  it "renders a list of registered_applications" do
    render
  end
end
