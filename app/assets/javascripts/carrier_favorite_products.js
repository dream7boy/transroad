$(document).ready(function() {
  // ====================================================
  var checkBoxes = document.querySelectorAll('.product__checkbox');
  var checkBoxLabels = document.querySelectorAll('.checkbox--container label');
  var maximumCheckedBoxes = 3;
  var trueArray = [];
  var checkBoxCounter = trueArray.length;
  // ====================================================
  window.onload = function() {
    countBoxOnLoad();
    checkBoxes.forEach(function(box) {
      box.addEventListener("click", function(event){
        trueArray = [];
        countBoxes();
        checkBoxCounter = trueArray.length;
        if (checkBoxCounter < maximumCheckedBoxes) { enableBoxes() }
        if (checkBoxCounter >= maximumCheckedBoxes) { disableBoxes() }
        trueArray = [];
      });
    });
  };
  // ====================================================
  function countBoxOnLoad() {
    countBoxes();
    checkBoxCounter = trueArray.length;
    if (checkBoxCounter >= maximumCheckedBoxes) { disableBoxes(); }
  }
  // ---------------------------------------------------
  function countBoxes() {
    for (var i = 0; i < checkBoxes.length; i++) {
      if (checkBoxes[i].checked === true) {
        trueArray.push(true);
      }
    }
  }
  // ---------------------------------------------------
  function disableBoxes() {
    for (var i = 0; i < checkBoxes.length; i++) {
      if (checkBoxes[i].checked === false) {
        checkBoxes[i].disabled = true;
        checkBoxLabels[i].classList.add("disabled");
      }
    }
  }
  // ---------------------------------------------------
  function enableBoxes() {
    for (var i = 0; i < checkBoxes.length; i++) {
      if (checkBoxes[i].checked === false) {
        checkBoxes[i].disabled = false;
        checkBoxLabels[i].classList.remove("disabled");
      }
    }
  }
  // ====================================================
})