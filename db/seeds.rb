# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

app = RegisteredApplication.create(name: Faker::App.name, url: "www.example.com")

10.times do 
  some_payload = {referer: Faker::Internet.domain_name, ip_address: Faker::Internet.ip_v6_address}
  Event.create(name: Faker::Hacker.noun, registered_application: app, payload: some_payload  )
end