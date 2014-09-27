
var stories = null;
var map_position = {};
var green_icon = 'green_map_marker.png'
var red_icon = 'red_map_marker.png'
var yellow_icon = 'yellow_map_marker.png'

function loadScript() {
  var script = document.createElement('script');
  script.type = 'text/javascript';
  script.src = 'https://maps.googleapis.com/maps/api/js?v=3.exp&' +
      'callback=getLocation';
  document.body.appendChild(script);
}


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


function format_story_content(story){
  content = "<div style='overflow:visible;'><h1>" +
            story.title +
            "</h1>" +
            "<p style='font-size: 150%;'>"+
            story.content +
            "</p>"+
            "</div>";
  return content;
}

function create_info_box(story) {
  return new google.maps.InfoWindow({ 
    content: format_story_content(story), 
    maxWidth: 1000 
  });
}

function create_markers(map){

  var marker_arr = []

  stories.forEach(function(element, index, array){

    var marker = new google.maps.Marker({
      position: {lat: Number(element.latitude), lng: Number(element.longitude)},
      icon: (element.mood == 'green')? green_icon : red_icon      
    });

    marker_arr.push(marker) ;

    var info_box = create_info_box(element);
    google.maps.event.addListener(marker, 'click', function() {
      info_box.open(map,marker);
    });

  });
  return marker_arr;

}

function initialize() {
  var mapOptions = {
    center: map_position,
    zoom: 3, draggable: true, 
    zoomControl: true, 
    scrollwheel: false, 
    disableDoubleClickZoom: false
  };
  
  var map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
  var markers = create_markers(map);

  var clusterStyles = [{
    textColor: 'black',
    url: yellow_icon,
    height: 57,
    width: 57,
    textSize: 12
  }]

  var clusterOptions = {
     gridSize: 50,
     styles: clusterStyles,
     maxZoom: 15
  };

  var marker_clusterer = new MarkerClusterer(map, markers, clusterOptions);

  toggle_map();
}

function toggle_map(){
  $('#map-container').children().each(function(){
    $(this).toggleClass('hidden');
  });


}

