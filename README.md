# blocmetrics
blocmetrics


curl -v -H "Accept: application/json" -H "Origin: http://registered_application.com" -H "Content-type: application/json" -X POST -d '{"event": {"name": "foobar"}}'  http://localhost:3000/api/events

curl -v -H "Accept: application/json" -H "Origin: http://registered_application.com" -H "Content-type: application/json" -X POST -d '{"event": {"name": "foobar", "payload": {"some_key": "Some data"}}}'  http://localhost:3000/api/events

=================================
curl -H "Content-Type: application/json" -d '{"user":{"email":"user2@example.com","password":"12345678"}}' -X POST http://localhost:3000/api/v1



Creating the users.  This work.

curl -H "Content-Type: application/json" -d '{"email":"user3@example.com","password":"12345678", "confirm_success_url":"http://localhost:3000/"}' -X POST http://localhost:3000/api/v1/auth

response:
{"status":"success","data":{"id":3,"email":"user2@example.com","created_at":"2015-05-01T05:08:17.356Z","updated_at":"2015-05-01T05:08:17.356Z","provider":"email","uid":"user2@example.com"}}

Login

curl -H 'Content-Type: application/json'   -H 'Accept: application/json' -d '{"email": "user2@example.com", "password": "12345678"}' -X POST http://localhost:3000/api/v1/auth/sign_in   -v

< access-token: nCiGZGYfEEVGGp9lSMzMsA
client: N0whXdy-P9_5Y7oANUPWaA
 uid: user2@example.com
 expiry: 1432348885

 curl -v -H "Accept: application/json" -H "Origin: http://registered_application.com" -H "Content-type: application/json" -H "access-token: nCiGZGYfEEVGGp9lSMzMsA" -H "client: N0whXdy-P9_5Y7oANUPWaA" -H "uid: user2@example.com" -H "expiry: 1432348885" -X POST -d '{"event": {"name": "foobar"}}'  http://localhost:3000/api/events

 it works.