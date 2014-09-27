$(document).ready(function(){

  $.ajax({
    type: "GET",
    url: "/stories.json",
    datatype: "json"
  })
  .done(function(data){
    stories = data;
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