// This script works with a form in the erb file. The form must
// have two hidden fields. One named "browser_lattitude", the 
// other named "browser_longitude".

// to call the script add onclick="get_browser_location(this.form);"
// to the submit button attributes. And you should be good to go!



var js_form = null;

function get_browser_location(form){
  js_form = form
  console.log('!!!');
   if(navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(showPosition, showError);
   } else {
    // not supported
   }
}

function showPosition(position) {
  var lat = position.coords.latitude;
  var lng = position.coords.longitude;

  js_form.browser_latitude.value = lat;
  js_form.browser_longitude.value = lng;
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
