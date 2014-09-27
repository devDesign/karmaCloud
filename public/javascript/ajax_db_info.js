$(document).ready(function(){

  $.ajax({
    type: "GET",
    url: "/stories.json",
    datatype: "json"
  })
  .done(function(data){
    stories = data;
    populate_accordion()
    loadScript();
  })
  .fail(function(){alert("fail");}); 

  $.ajax({
    type: "GET",
    url: "/comments.json",
    datatype: "json"
  })
  .done(function(data){
    comments = data;
  })
  .fail(function(){alert("fail");}); 
});

var stories = null;
var comments = null;

function populate_accordion() {
  var $new_stories = $('#accordion');

  for(var i = 0; i < 10; i++){

    //comments, link to story and red/green classes

    $title  = $('<h3></h3>').text(stories[i].title);
    $content = $("<p></p>").text(stories[i].content);
    $user_id = $("<p></p>").text(stories[i].user_name);
    $created_at = $("<p></p>").text(stories[i].created_at);

    $div = $("<div></div>").append($content, [$user_id, $created_at]);
    $new_stories.append($title, [$div]);
  }

   $( "#accordion" ).accordion({
      collapsible: true
    });
}