//DatePicker and DateTimePicker
$(function(){
  //DatePicker
  $('#datepicker1').datetimepicker({
    format : "YYYY/MM/DD",
    icons: {
      previous: "fa fa-arrow-left",
      next: "fa fa-arrow-right"
    }
  });
  $('#datepicker2').datetimepicker({
    format : "YYYY/MM/DD",
    icons: {
      previous: "fa fa-arrow-left",
      next: "fa fa-arrow-right"
    },
    useCurrent: false //Important! See issue #1075
  });
  $("#datepicker1").on("dp.change", function (e) {
    $('#datepicker2').data("DateTimePicker").minDate(e.date);
  });
  $("#datepicker2").on("dp.change", function (e) {
    $('#datepicker1').data("DateTimePicker").maxDate(e.date);
  });

  $('#datepicker3').datetimepicker({
    format : "YYYY/MM/DD",
    icons: {
      previous: "fa fa-arrow-left",
      next: "fa fa-arrow-right"
    }
  });
  $('#datepicker4').datetimepicker({
    format : "YYYY/MM/DD",
    icons: {
      previous: "fa fa-arrow-left",
      next: "fa fa-arrow-right"
    },
    useCurrent: false //Important! See issue #1075
  });
  $("#datepicker3").on("dp.change", function (e) {
    $('#datepicker4').data("DateTimePicker").minDate(e.date);
  });
  $("#datepicker4").on("dp.change", function (e) {
    $('#datepicker3').data("DateTimePicker").maxDate(e.date);
  });

  //DateTimePicker
  $('#datetimepicker1').datetimepicker({
    format : "YYYY/MM/DD HH:mm",
    icons: {
      time: "fa fa-clock-o",
      date: "fa fa-calendar",
      up: "fa fa-arrow-up",
      down: "fa fa-arrow-down",
      previous: "fa fa-arrow-left",
      next: "fa fa-arrow-right"
    }
  });
  $('#datetimepicker2').datetimepicker({
    format : "YYYY/MM/DD HH:mm",
    icons: {
      time: "fa fa-clock-o",
      date: "fa fa-calendar",
      up: "fa fa-arrow-up",
      down: "fa fa-arrow-down",
      previous: "fa fa-arrow-left",
      next: "fa fa-arrow-right"
    },
    useCurrent: false //Important! See issue #1075
  });
  $("#datetimepicker1").on("dp.change", function (e) {
    $('#datetimepicker2').data("DateTimePicker").minDate(e.date);
  });
  $("#datetimepicker2").on("dp.change", function (e) {
    $('#datetimepicker1').data("DateTimePicker").maxDate(e.date);
  });
});
