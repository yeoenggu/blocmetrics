require 'rails_helper'

RSpec.describe "registered_applications/show", type: :view do
  before(:each) do
    @registered_application = assign(:registered_application, RegisteredApplication.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
