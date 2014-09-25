$(document).ready(function() {
  
  $('.logout').on('click',function() {
    $.ajax({
      type: 'DELETE',
      url: '/user_session'
    });
  });

});
