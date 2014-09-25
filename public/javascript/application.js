

$(document).ready(function() {

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

  $(function() {
    $( "#accordion" ).accordion({
      collapsible: true
    });
  });
  
  $(function() {
    $( "#top_5" ).accordion({
      collapsible: true
    });
  });
});



