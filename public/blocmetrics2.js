(function(window) {
  var blocmetrics = window.blocmetrics || window.Blocmetrics || {};
  var _bm_request = null;
  var _bm_signin_request = null;

  if (blocmetrics.isSignIn === 'undefined'|| blocmetrics.isSignIn === null) {
    blocmetrics.isSignIn = false;
  }

  var access_token = null;
  var client = null;
  var uid = null;
  var expiry = null;

  function trackEvent(event) {
    if (blocmetrics.isSignIn) {
      _bm_request = new XMLHttpRequest();
      sendEvent(_bm_request, event, onStateChange);
    }
    else {
      _bm_signin_request = new XMLHttpRequest();
      _bm_signin_request.open("POST", "http://localhost:3000/api/v1/auth/sign_in", true);
      _bm_signin_request.setRequestHeader("Content-Type", "application/json");
      _bm_signin_request.onreadystatechange = onStateChangeSignIn.bind(undefined, event);

      _bm_signin_request.send('{"email": "user2@example.com", "password": "12345678"}');
    }
  }

   blocmetrics.report = function () {
    var _bm_event = {
      event_name: "sale",
    }
    trackEvent(_bm_event)
  }

  function onStateChangeSignIn(event) {
    if (_bm_signin_request.readyState == 0 || _bm_signin_request.readyState == 4) {
      if (isRequestSuccessful (_bm_signin_request)) {    // defined in ajax.js
        rememberCredentials(_bm_signin_request);
        blocmetrics.isSignIn = true;
        _bm_request = new XMLHttpRequest();
        sendEvent(_bm_request, event, onStateChange);
      }
      else {
          alert ("Signin Operation failed.");
      }
    }
  }

  function onStateChange(event) {
    console.log("Event passed to onStateChange(event)", event);
    if (_bm_request.readyState == 0 || _bm_request.readyState == 4) {
      if (isRequestSuccessful (_bm_request)) {    // defined in ajax.js
        rememberCredentials(_bm_request);
      }
      else {
        alert ("trackEvent Operation failed.");
      }
    }
  }

  function sendEvent(request, event, callback) {
    request.open("POST", "http://localhost:3000/api/v1/events", true);

    request.setRequestHeader("access-token", blocmetrics.access_token)
    request.setRequestHeader("client", blocmetrics.client)
    request.setRequestHeader("uid", blocmetrics.uid)
    request.setRequestHeader("expiry", blocmetrics.expiry)

    request.setRequestHeader("Content-Type", "application/json");
    
    request.onreadystatechange = callback.bind(undefined, event);
    request.send(JSON.stringify(event));
  }

  // returns whether the HTTP request was successful
  function isRequestSuccessful (httpRequest) {
    // IE: sometimes 1223 instead of 204
    var success = (httpRequest.status == 0 || 
        (httpRequest.status >= 200 && httpRequest.status < 300) || 
        httpRequest.status == 304 || httpRequest.status == 1223);
    
    return success;
}
  // remember credentials
  function rememberCredentials(request) {
    blocmetrics.access_token = request.getResponseHeader ("access-token");
    blocmetrics.client = request.getResponseHeader ("client");
    blocmetrics.uid = request.getResponseHeader ("uid");
    blocmetrics.expiry = request.getResponseHeader ("expiry");
    
  }

  window.blocmetrics = blocmetrics
}(window));