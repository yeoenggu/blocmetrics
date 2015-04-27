require 'rails_helper'

describe "Event Create API" do
  before do
    # Need to registered the app 
    @registered_app = create :registered_application, url: Faker::Internet.domain_name
  end

  it "create an event" do

    parameters = {event: {name: "buy", payload: {product_name: "HeadFirstjQuery"}}}
    # parameters_string = '{"event": {"name": "buy", "payload": {"product_name": "HeadFirstjQuery"}}}' 
    headers = {Accept: "application/json", Origin: @registered_app.url , "Content-type": "application/json"}
    post "/api/events", parameters.to_json, headers

    expect(response.status).to eq(201)
    expect(response.content_type).to eq("application/json")

    expect(Event.count).to eq(1)
    event = Event.first # refactor later ... lazy bum

    expect(Event.first.name).to eq("buy")
    expect(Event.first.payload).to eq({"product_name"=> "HeadFirstjQuery"})
    expect(Event.first.registered_application).to eq @registered_app
  end
end # end of "Event Create API"