$(function (){
  $('#carrier_post_code').jpostal({
    postcode : [ '#carrier_post_code' ],
    address  : {
      '#carrier_prefecture' : '%3',
      '#carrier_ward'       : '%4',
      '#carrier_street'     : '%5'
    }
  });
});