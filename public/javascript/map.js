  $(function(){
  $.ajax({
    type: "GET",
    url: "/stories.json",
    datatype: "json"
  })
  .done(function(data){
    stories = data;
    getLocation();
  })

  .fail(function(){alert("fail");}); 
});

var stories = null;

var map_position = {};


function getLocation() {
  if(navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(showPosition, showError);
  } else {
    // not supported
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


function create_info_box(story) {
  return new google.maps.InfoWindow({ 
    content: story.content, 
    maxWidth: 300 
  });
}

function create_markers(map){

  stories.forEach(function(element, index, array){

    console.log(element.latitude, element.longitude);

    var marker = new google.maps.Marker({
      position: {lat: Number(element.latitude), lng: Number(element.longitude)},
      map: map,
      title:"Hello World!"  
    });

    var info_box = create_info_box(element);
    google.maps.event.addListener(marker, 'click', function() {
      info_box.open(map,marker);
    });

  });

}

function initialize() {

  var mapOptions = {
    center: map_position,
    zoom: 13, draggable: true, 
    zoomControl: true, 
    scrollwheel: false, 
    disableDoubleClickZoom: false
  };
  
  var map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
  create_markers(map);
}

