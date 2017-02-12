App.increment_notification = App.cable.subscriptions.create("IncrementNotificationChannel", {
  connected: function() {
  },

  disconnected: function() {
  },

  received: function(data) {

    /* Users index page */
    $("#u" + data.requested_friend.id + " .friendstatus").css({"color": "lightcoral", "font-style": "oblique", "font-size": ".9rem"}).html("Added friend");


    /* Header notification badge and dropdown */
    $(".notification-friend-invitations#nfi" + data.requested_friend.id).css("display", "inline-block");
    $(".notification-friend-invitations#nfi" + data.requested_friend.id + " li").html(data.friend_requests_notification);
    $("#notification-dropdown").append(data.content);

 
    /* Users show page */
    $(".status-with-action#u" + data.friend_requestor.id).html(data.confirm_delete_buttons);
    $(".status-with-action#u" + data.requested_friend.id).html("<span style='color: lightcoral; font-style: oblique; font-size: 1rem;'>Friend Request Sent</span>");

    /* 
     * Friend requests index page
     */
    /* Friend invitations heading */
    $(".friend-requests > .headline").html("Respond to your " + data.requested_friend_invitations_count + " Friend Requests");
    /* Friend request items */
    $(".col.s6.friend-requests").append("<div class='row friend-request' id='" + data.friend_request.id + "'><div class='col s12'><div class='card medium'><div class='card-image'><img src='" + data.friend_requestor.avatar.url + "' class='avetar activator'/><span class='card-title'><a href='/users/" + data.friend_requestor.id + "'>" + data.friend_requestor.first_name + " " + data.friend_requestor.last_name + "</a></span></div><div class='card-content'><p style='color: lightblue; font-style: oblique; font-size: 1rem;'>" + data.friend_requestor.email + "</p><p style='color: lightcoral; font-style: oblique; font-size: .9rem;'>" + data.gender + "</p></div><div class='card-action'><a href='/users/" + data.requested_friend.id + "/friends?friender_id=" + data.friend_requestor.id + "' data-method='post' data-remote='true' data-confirm='Click OK to accept " + data.friend_requestor.first_name + " " + data.friend_requestor.last_name + "'s friend request.'>Confirm</a><a href='/friend_requests/" + data.friend_request.id + "' data-method='delete' data-remote='true' data-confirm='Are you sure you want to delete " + data.friend_requestor.first_name + " " + data.friend_requestor.last_name + "'s friend request?'>Delete request</a></div></div></div></div></div>");
  },

  speak: function(message) {
    this.perform("speak", { message: message });
  }
});
