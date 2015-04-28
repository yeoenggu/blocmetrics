require 'rails_helper'

describe "Event Create API" do
  before do
    # Need to registered the app 
    @registered_app = create :registered_application, url: Faker::Internet.domain_name
  end

  it "create an event with payload" do

    parameters = {event: {name: "buy", payload: {product_name: "HeadFirstjQuery"}}}
    
    headers = {Accept: "application/json", Origin: @registered_app.url , "Content-type": "application/json"}
    post "/api/events", parameters.to_json, headers

    expect(response.status).to eq(201)
    expect(response.content_type).to eq("application/json")

    expect(Event.count).to eq(1)
    event = Event.first 

    expect(event.name).to eq("buy")
    expect(event.payload).to eq({"product_name"=> "HeadFirstjQuery"})
    expect(event.registered_application).to eq @registered_app
  end

  it "create an event without payload" do
    parameters = {event: {name: "buy"}}

    headers = {Accept: "application/json", Origin: @registered_app.url , "Content-type": "application/json"}
    post "/api/events", parameters.to_json, headers

    expect(response.status).to eq(201)
    expect(response.content_type).to eq("application/json")

    expect(Event.count).to eq(1)
    event = Event.first 

    expect(event.name).to eq("buy")
    expect(event.payload).to eq(nil)
    expect(event.registered_application).to eq @registered_app
  end
end # end of "Event Create API"