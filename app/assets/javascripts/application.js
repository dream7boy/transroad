//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require moment
//= require moment/ja.js
//= require bootstrap-datetimepicker
//= require cocoon
//= require jquery-fileupload/basic
//= require cloudinary/jquery.cloudinary
//= require attachinary
//= require attachinary_template
//= require_tree .


// AUTO CLEAR ALERT AFTER X SECONDS
$('document').ready(function() {
  setTimeout(function() {
    $('.alert').slideUp();
  }, 3000);
});
