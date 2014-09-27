$(document).ready(function() {
  $( "#create_story" ).dialog({
  autoOpen: false,
  width: 900,
  height: 450,
  modal: true,
  resizable: true,
  title: "Create a Story" 
  });

  // Link to open the dialog
  $( "#create_story-link" ).click(function( event ) {
    $( "#create_story" ).dialog( "open" );
      event.preventDefault();
    }); 


  $( "#profiles" ).dialog({
    autoOpen: false,
    width: 500,
    height: 600,
    modal: true,
    resizable: true,
    title: "profiles" 
  });

  // Link to open the dialog
  $( "#profiles-link" ).click(function( event ) {
    $( "#profiles" ).dialog( "open" );
      event.preventDefault();
  });
  
  $( "#stories" ).dialog({
    autoOpen: false,
    width: 500,
    height: 600,
    modal: true,
    resizable: true,
    title: "All Stories" 
  });

  // Link to open the dialog
  $( "#stories-link" ).click(function( event ) {
    $( "#stories" ).dialog( "open" );
    event.preventDefault();
  });

  $( "#login" ).dialog({
    autoOpen: false,
    width: 400,
    modal: true,
    resizable: false,
    title: "Login to Karma Cloud" 
  });

  // Link to open the dialog
  $( "#login-link" ).click(function( event ) {
    $( "#login" ).dialog( "open" );
    event.preventDefault();
  });

  $( "#create_user" ).dialog({
    autoOpen: false,
    width: 400,
    modal: true,
    resizable: false,
    title: "Welcome to Karma Cloud"     
  });

  // Link to open the dialog
  $( "#create_user-link" ).click(function( event ) {
    $( "#create_user" ).dialog( "open" );
    event.preventDefault();
  });

  // $(function() {
  //   $( "#accordion" ).accordion({
  //     collapsible: true
  //   });
  // });
  
  $(function() {
    $( "#top_5" ).accordion({
      collapsible: true
    });
  });

  //Register login submit button
  $("#form_submit_btn").on("click", function(e){
    e.preventDefault();
    get_browser_location($("#location_form")[0]);
  });

  //Register login create user button
  $("#create_user_button").on("click", function(e){
    e.preventDefault();
    get_browser_location($("#create_user_form")[0]);
  });


});



