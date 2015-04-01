require 'rails_helper'

RSpec.describe "registered_applications/new", type: :view do
  before(:each) do
    assign(:registered_application, RegisteredApplication.new())
  end

  it "renders new registered_application form" do
    render

    assert_select "form[action=?][method=?]", registered_applications_path, "post" do
    end
  end
end
