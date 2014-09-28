$(document).ready(loadScript);

function loadScript() {
  var script = document.createElement('script');
  script.type = 'text/javascript';
  script.src = 'https://maps.googleapis.com/maps/api/js?v=3.exp&' +
      'callback=getLocation';
  document.body.appendChild(script);
}


function initialize() {
  var mapOptions = {
    center: map_position,
    zoom: 12, draggable: true, 
    zoomControl: true, 
    scrollwheel: false, 
    disableDoubleClickZoom: false
  };
  
  var map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);

var marker = new google.maps.Marker({
 map: theMap,
 draggable: true,
 position: new google.maps.LatLng(49.47216, -123.76307),
 visible: true
});
        
var boxText = document.createElement("div");
boxText.style.cssText = "border: 1px solid black; margin-top: 8px; background: yellow; padding: 5px;";
boxText.innerHTML = "City Hall, Sechelt<br>British Columbia<br>Canada";
        
var myOptions = {
         content: boxText
        ,disableAutoPan: false
        ,maxWidth: 0
        ,pixelOffset: new google.maps.Size(-140, 0)
        ,zIndex: null
        ,boxStyle: { 
          background: "url('tipbox.gif') no-repeat"
          ,opacity: 0.75
          ,width: "280px"
         }
        ,closeBoxMargin: "10px 2px 2px 2px"
        ,closeBoxURL: "http://www.google.com/intl/en_us/mapfiles/close.gif"
        ,infoBoxClearance: new google.maps.Size(1, 1)
        ,isHidden: false
        ,pane: "floatPane"
        ,enableEventPropagation: false
};

var ib = new InfoBox(myOptions);
ib.open(theMap, marker);

}