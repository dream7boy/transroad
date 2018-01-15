$(document).ready(function() {
  // The 'link_to_remove_association.remove_fields' is displayed by default.
  // Made more sense to "Hide the first one" than "Show all of them EXCEPT the first one"
  if($(".fields-row").length === 1){
    $(".remove_fields")[0].style.display="none";
  }

  $('#shipment__pickup__container')
  .on('cocoon:after-insert', function() {
    $(".remove_fields")[0].style.display="none";
  })
  .on("cocoon:after-remove", function() {
      $(".remove_fields")[0].style.display="none";
  });

});