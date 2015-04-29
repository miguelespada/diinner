//= require attachinary

(($) ->

  $.attachinary.config.template = """
        <div>
          <% for(var i=0; i<files.length; i++){ %>
            <div>
              <p> Image: <%= i + 1 %> </p>
              <% if(files[i].resource_type == "raw") { %>
                <div class="raw-file"></div>
              <% } else { %>
                <img
                  src="<%= $.cloudinary.url(files[i].public_id, { "version": files[i].version, "format": 'jpg', "crop": 'fill', "width": 150}) %>"
                  />
              <% } %>
              <a href="#" data-remove="<%= files[i].public_id %>" data-number="<%= i + 1 %>">Remove</a>
              <% if( i > 0) %>
               | <a href="#" data-up="<%= files[i].public_id %>" data-number="<%= i + 1 %>">up</a>
              <p> Id: <%= files[i].public_id %> </p>
            </div>
          <% } %>
        </div>
      """
 
)(jQuery)