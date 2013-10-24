$(document).ready(function() {


  $('form').on('submit', function(event) {
    event.preventDefault();

    var draw = Math.floor(1 + Math.random() * 60);

    var request = $.post('/rolls', {value: draw});

    request.done(function(data) {
      $('#card').children().remove();
      $('#card').append(data);
    });
  });
});


