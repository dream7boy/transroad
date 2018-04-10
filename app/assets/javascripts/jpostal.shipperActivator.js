$(function (){
  $('#shipper_post_code').jpostal({
    postcode : [ '#shipper_post_code' ],
    address  : {
      '#shipper_prefecture' : '%3',
      '#shipper_ward'       : '%4',
      '#shipper_street'     : '%5'
    }
  });
});