$(document).ready(function() {
  
  $('.logout').on('click',function() {
    $.ajax({
      url: '/user_session',
      type: 'DELETE'
    });
  });

});
