$(function (){
  $('#shipment_pickups_attributes_0_post_code').jpostal({
    postcode : [ '#shipment_pickups_attributes_0_post_code' ],
    address  : {
      '#shipment_pickups_attributes_0_prefecture' : '%3',
      '#shipment_pickups_attributes_0_ward'       : '%4',
      '#shipment_pickups_attributes_0_street'     : '%5'
    }
  });
});
$(function (){
  $('#shipment_deliveries_attributes_0_post_code').jpostal({
    postcode : [ '#shipment_deliveries_attributes_0_post_code' ],
    address  : {
      '#shipment_deliveries_attributes_0_prefecture' : '%3',
      '#shipment_deliveries_attributes_0_ward'       : '%4',
      '#shipment_deliveries_attributes_0_street'     : '%5'
    }
  });
});