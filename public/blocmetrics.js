(function(window) {
  var blocmetrics = window.blocmetrics || window.Blocmetrics || {};

  function trackEvent(event) {
    var _bm_request = new XMLHttpRequest();
   
    _bm_request.open("POST", "http://localhost:3000/api/events", true);
     _bm_request.setRequestHeader("Content-Type", "application/json");
    _bm_request.onreadystatechange = function() {
      // left empty
    };
    _bm_request.send(JSON.stringify(event));
  }

   blocmetrics.report = function () {
    var _bm_event = {
      event_name: "sale",
    }
    trackEvent(_bm_event)
  }

  window.blocmetrics = blocmetrics
}(window));


