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



// POLYFILL FOR .INCLUDES()
if (!String.prototype.includes) {
  String.prototype.includes = function(search, start) {
    'use strict';
    if (typeof start !== 'number') {
      start = 0;
    }
    if (start + search.length > this.length) {
      return false;
    } else {
      return this.indexOf(search, start) !== -1;
    }
  };
}



// POLYFILL FOR .FOREACH()
if (window.NodeList && !NodeList.prototype.forEach) {
  NodeList.prototype.forEach = function (callback, thisArg) {
    thisArg = thisArg || window;
    for (var i = 0; i < this.length; i++) {
      callback.call(thisArg, this[i], i, this);
    }
  };
}