// IMPLEMENTATION

// 1. Add button handler that links to get_brower_location()
// 2. two hidden input fields: browser_latitude, browser_longitude
$(document).ready(function(){
  $("#form_submit_btn").on("click", function(e){
      e.preventDefault();
      console.log("calling method");
      get_browser_location($("#location_form")[0]);
  });
});



function get_browser_location(form){
  console.log(form);
  
   if(navigator.geolocation) {
    console.log("There is a navigator: about to make an async call");
    console.log(navigator.geolocation);
    navigator.geolocation.getCurrentPosition(showPosition, showError);
   } else {
      console.log("no navigator");
   }

   function showPosition(position) {

    var lat = position.coords.latitude;
    var lng = position.coords.longitude;

    console.log(lat + " " + lng);

    console.log(form);
    form.browser_latitude.value = lat;
    form.browser_longitude.value = lng;

    form.submit(); 
    }

    function showError(error) {

      console.log("oops something is wrong");
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
