// IMPLEMENTATION

// 1. Add button handler that links to get_brower_location()
// 2. two hidden input fields: browser_latitude, browser_longitude

function get_browser_location(form){
  
   if(navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(showPosition, showError);
   } else {
      console.log("no navigator");
   }

   function showPosition(position) {

    var lat = position.coords.latitude;
    var lng = position.coords.longitude;

    form.browser_latitude.value = lat;
    form.browser_longitude.value = lng;

    form.submit(); 
    }

    function showError(error) {
      switch(error.code) {
      case error.PERMISSION_DENIED:
        console.log("User denied the request for Geolocation.");
        break;
      case error.POSITION_UNAVAILABLE:
        console.log("Location information is unavailable.");
        break;
      case error.TIMEOUT:
        console.log("The request to get user location timed out.");
        break;
      case error.UNKNOWN_ERROR:
        console.log("An unknown error occurred.");
        break;
     }
  }

}
