require 'rails_helper'

describe "Event Create API" do
  before do
    # Need to registered the app 
    @registered_app = create :registered_application, url: Faker::Internet.domain_name

  end

  it "create an event" do

    # sign in first to get credentials.

    user_email = "user89@example.com"
    user_password = "helloworld"

    # create the user first
    parameters = {email: user_email, password: user_password, confirm_success_url: "http://www.google.com"}
    headers = {Accept: "application/json", "Content-type": "application/json"}
    post "/api/v1/auth", parameters.to_json, headers

    p "*"*8
    p "Creating user"
    p response.inspect
    p "*"*8

    # sign in 
    parameters = {email: user_email, password: user_password}
    headers = {Accept: "application/json", "Content-type": "application/json"}
    post "/api/v1/auth/sign_in", parameters.to_json, headers

    p "*"*8
    p "Sign in user"
    p response.inspect
    p "*"*8

    p "access token: " + response.header['access-token']
    p "client: " + response.header['client']
    p "uid: " + response.header['uid']
    p "expiry: " + response.header['expiry']

    # create the event

    parameters = {event: {name: "buy", payload: {product_name: "HeadFirstjQuery"}}}
    headers = {Accept: "application/json", Origin: @registered_app.url , "Content-type": "application/json","access-token": response.header['access-token'], "client": response.header['client'], "uid": response.header['uid'], "expiry": response.header['expiry'] }
    post "/api/v1/events", parameters.to_json, headers

    expect(response.status).to eq(201)
    expect(response.content_type).to eq("application/json")

    expect(Event.count).to eq(1)
    event = Event.first # refactor later ... lazy bum

    expect(Event.first.name).to eq("buy")
    expect(Event.first.payload).to eq({"product_name"=> "HeadFirstjQuery"})
    # expect(Event.first.registered_application).to eq @registered_app
  end
end # end of "Event Create API"