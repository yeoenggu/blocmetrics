# blocmetrics
blocmetrics


curl -v -H "Accept: application/json" -H "Origin: http://registered_application.com" -H "Content-type: application/json" -X POST -d '{"event": {"name": "foobar"}}'  http://localhost:3000/api/events

curl -v -H "Accept: application/json" -H "Origin: http://registered_application.com" -H "Content-type: application/json" -X POST -d '{"event": {"name": "foobar", "payload": {"some_key": "Some data"}}}'  http://localhost:3000/api/events