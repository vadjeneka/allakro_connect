        <% @message.each do |message| %>
          <% if message.user != current_user%>
            <div class="flex justify-end py-1">
              <div class="bg-gray-200 p-5 rounded-2xl rounded-tl-none w-2/5">
                  <p><%= message.content %></p>
                  <small class="float-right"><%= message.user.email%> <strong><%= message.created_at&.strftime("%I: %M %p") %></strong></small>
              </div>
            </div>
          <%else%>
            <div class="flex justify-start py-1">
                <div class="bg-blue-300 text-green-900 p-5 rounded-2xl rounded-tr-none w-2/5">
                  <p><%= message.content %></p>
                  <small class="float-right"><%= message.user.email %>  <strong><%= message.created_at&.strftime("%I: %M %p") %></strong></small>
                </div>
            </div>
          <%end%>
        <%end%>