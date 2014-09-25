alert(gon.test);

var map_position = {};

function getLocation() {
  if(navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(showPosition, showError);
  } else {
    element.innerHTML = "GeoLocation is not supported by the Browser";
  }
}

function showPosition(position) {
  var lat = position.coords.latitude;
  var lng = position.coords.longitude;

  map_position["lat"] = lat;
  map_position["lng"] = lng;

  initialize();
}

function showError(error) {
  switch(error.code) {
  case error.PERMISSION_DENIED:
    element.innerHTML = "User denied the request for Geolocation."
    break;
  case error.POSITION_UNAVAILABLE:
    element.innerHTML = "Location information is unavailable."
    break;
  case error.TIMEOUT:
    element.innerHTML = "The request to get user location timed out."
    break;
  case error.UNKNOWN_ERROR:
    element.innerHTML = "An unknown error occurred."
    break;
 }
}

function initialize() {
  var mapOptions = {
    center: map_position,
    zoom: 18
  };
  
  var map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);

  var marker = new google.maps.Marker({
    position: map_position,
    map: map,
    title:"Hello World!"
  });
}