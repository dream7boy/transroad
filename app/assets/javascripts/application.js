//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require moment
//= require moment/ja.js
//= require bootstrap-datetimepicker
//= require cocoon
//= require_tree .


// AUTO CLEAR ALERT AFTER X SECONDS
$('document').ready(function() {
  setTimeout(function() {
    $('.alert').slideUp();
  }, 1250);
});