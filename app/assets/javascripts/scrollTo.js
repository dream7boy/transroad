$(document).ready(function() {
  const target = '#carrier_areas_covered--container div.ms-parent.form-control.grouped_select.required';
  $(target)[0].addEventListener('click', function(e) {
    $('html, body').animate({
      scrollTop: $(target).offset().top
    }, 400);
  });
});