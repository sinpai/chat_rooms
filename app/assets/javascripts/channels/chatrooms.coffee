App.chatrooms = App.cable.subscriptions.create "ChatroomsChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    active_chatroom = $("[data-behavior='messages'][data-chatroom-id='#{data.chatroom_id}']")
    if active_chatroom.length > 0

      if document.hidden
        if $(".strike").length == 0
          active_chatroom.append("<div class='strike'><span>Unread Messages</span></div>")

        if Notification.permission == "granted"
          new Notification(data.username, {body: data.body})

      else
        App.last_read.update(data.chatroom_id)

      # Insert the message
      active_chatroom.append("<div class='message #{if data.username == $('span.user-name').text() then 'from-you' else 'to-you'}'><img src='../assets/chat-room-item-ava.png' alt=''><div class='message-text'>#{data.body}</div></div>")
      active_chatroom.stop().animate scrollTop: active_chatroom[0].scrollHeight
    else
      $("[data-behavior='chatroom-link'][data-chatroom-id='#{data.chatroom_id}']").find('.chat-room-user-status').removeClass('offline').addClass('online')

  send_message: (chatroom_id, message) ->
    @perform "send_message", {chatroom_id: chatroom_id, body: message}