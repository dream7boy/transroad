$.attachinary.config.template = '\
  <ul>\
    <% for(var i=0; i<files.length; i++){ %>\
      <li>\
        <% if(files[i].resource_type == "raw") { %>\
          <div class="raw-file"></div>\
        <% } else { %>\
          <img\
            src="<%= $.cloudinary.url(files[i].public_id, { "version": files[i].version, "format": "jpg", "crop": "fill", "width": 380, "height": 240, "gravity": "face:center" }) %>"\
            alt="" width="190" height="120" />\
        <% } %>\
        <a href="#" data-remove="<%= files[i].public_id %>"><i class="md md-clear md-2x"></i></a>\
      </li>\
    <% } %>\
  </ul>\
';