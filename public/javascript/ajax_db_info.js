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

  $.ajax()
    .done(function(data){})
    .fail(function(){});
});