IMPLEMENTATION

1. form with id="location_form"
2. two hidden input fields: browser_latitude, browser_longitude
3. a button with id="form_submit_btn"
4. Jquery must be loaded before login_location.js


$(document).ready(function(){
  $("#form_submit_btn").on("click", function(e){
    e.preventDefault();
    get_browser_location($("#location_form")[0]);
  });
});
var js_form = null;

function get_browser_location(form){
  js_form = form;
  
   if(navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(showPosition, showError);
   } else {
    
   }
}

function showPosition(position) {
  var lat = position.coords.latitude;
  var lng = position.coords.longitude;

  console.log(lat + " " + lng);

  js_form.browser_lattitude.value = lat;
  js_form.browser_longitude.value = lng;

  js_form.submit();
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
