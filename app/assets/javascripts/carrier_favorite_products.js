$(document).ready(function() {
  var checkBoxes = document.querySelectorAll('.product__checkbox');
  var checkBoxLabels = document.querySelectorAll('.checkbox--container label');
  var maximumCheckedBoxes = 3;
  var trueArray = [];
  checkBoxes.forEach(function(box) {
    box.addEventListener("click", function(event){

      // START =========================================================================
      // Count how many boxes are selected
      // console.log('Counting...');
      for (var i = 0; i < checkBoxes.length; i++) {
        if (checkBoxes[i].checked === true) {
          trueArray.push(true);
        }
      }
      var checkBoxCounter = trueArray.length;
      // console.log(checkBoxCounter);
      // END ===========================================================================

      // START =========================================================================
      // If the count is less than 3, enable the boxes that are not checked
      if (checkBoxCounter < maximumCheckedBoxes) {
        // console.log('LESS THAN');
        for (var i = 0; i < checkBoxes.length; i++) {
          if (checkBoxes[i].checked === false) {
            checkBoxes[i].disabled = false;
            checkBoxLabels[i].classList.remove("disabled");
          }
        }
      }
      // END ===========================================================================

      // START =========================================================================
      // If the count is equal to 3, then disable the boxes and dim the labels that are not checked
      if (checkBoxCounter >= maximumCheckedBoxes) {
        // console.log('MORE or EQUAL TO');
        for (var i = 0; i < checkBoxes.length; i++) {
          if (checkBoxes[i].checked === false) {
            checkBoxes[i].disabled = true;
            checkBoxLabels[i].classList.add("disabled");
          }
        }
      }
      // END ===========================================================================

      // START =========================================================================
      // Once it's all done, empty the array
      trueArray = [];
      // END ===========================================================================

    });
  });
})