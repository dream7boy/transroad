$(function(){
  //DatePicker
  $('#datepicker6').datetimepicker({
    format : "YYYY/MM/DD",
    icons: {
      previous: "fa fa-arrow-left",
      next: "fa fa-arrow-right"
    }
  });
  $('#datepicker7').datetimepicker({
    format : "YYYY/MM/DD",
    icons: {
      previous: "fa fa-arrow-left",
      next: "fa fa-arrow-right"
    },
    useCurrent: false //Important! See issue #1075
  });
  $("#datepicker6").on("dp.change", function (e) {
    $('#datepicker7').data("DateTimePicker").minDate(e.date);
  });
  $("#datepicker7").on("dp.change", function (e) {
    $('#datepicker6').data("DateTimePicker").maxDate(e.date);
  });

  $('#datepicker8').datetimepicker({
    format : "YYYY/MM/DD",
    icons: {
      previous: "fa fa-arrow-left",
      next: "fa fa-arrow-right"
    }
  });
  $('#datepicker9').datetimepicker({
    format : "YYYY/MM/DD",
    icons: {
      previous: "fa fa-arrow-left",
      next: "fa fa-arrow-right"
    },
    useCurrent: false //Important! See issue #1075
  });
  $("#datepicker8").on("dp.change", function (e) {
    $('#datepicker9').data("DateTimePicker").minDate(e.date);
  });
  $("#datepicker9").on("dp.change", function (e) {
    $('#datepicker8').data("DateTimePicker").maxDate(e.date);
  });

  //DateTimePicker
  $('#datetimepicker6').datetimepicker({
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
  $('#datetimepicker7').datetimepicker({
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
  $("#datetimepicker6").on("dp.change", function (e) {
    $('#datetimepicker7').data("DateTimePicker").minDate(e.date);
  });
  $("#datetimepicker7").on("dp.change", function (e) {
    $('#datetimepicker6').data("DateTimePicker").maxDate(e.date);
  });
});
